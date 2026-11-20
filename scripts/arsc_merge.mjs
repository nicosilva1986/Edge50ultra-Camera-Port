import fs from 'node:fs';
import { crc32, inflateRawSync } from 'node:zlib';

const RES_TABLE_TYPE = 0x0002;
const RES_STRING_POOL_TYPE = 0x0001;
const RES_TABLE_PACKAGE_TYPE = 0x0200;
const RES_TABLE_TYPE_TYPE = 0x0201;
const UTF8_FLAG = 1 << 8;
const SORTED_FLAG = 1 << 0;
const TYPE_STRING = 0x03;

const EOCD_SIG = 0x06054b50;
const CD_SIG = 0x02014b50;
const LOCAL_SIG = 0x04034b50;

function readUtf8PoolLen(buf, pos) {
  let val = buf[pos];
  if (val & 0x80) {
    val = ((val & 0x7f) << 8) | buf[pos + 1];
    return [val, pos + 2];
  }
  return [val, pos + 1];
}

function encodeUtf8PoolLen(val) {
  if (val > 0x7fff) throw new Error(`string exceeds UTF-8 pool length limit: ${val}`);
  if (val >= 0x80) return Buffer.from([0x80 | (val >> 8), val & 0xff]);
  return Buffer.from([val]);
}

function parseStringPoolChunk(buf, offset) {
  const type = buf.readUInt16LE(offset);
  const headerSize = buf.readUInt16LE(offset + 2);
  const chunkSize = buf.readUInt32LE(offset + 4);
  if (type !== RES_STRING_POOL_TYPE || headerSize !== 28) {
    throw new Error(`unexpected string pool header type=0x${type.toString(16)} headerSize=${headerSize}`);
  }
  const stringCount = buf.readUInt32LE(offset + 8);
  const styleCount = buf.readUInt32LE(offset + 12);
  const flags = buf.readUInt32LE(offset + 16);
  const stringsStart = buf.readUInt32LE(offset + 20);
  const stylesStart = buf.readUInt32LE(offset + 24);
  const isUtf8 = (flags & UTF8_FLAG) !== 0;

  const stringOffsets = [];
  for (let i = 0; i < stringCount; i += 1) {
    stringOffsets.push(buf.readUInt32LE(offset + 28 + i * 4));
  }
  const strings = [];
  for (let i = 0; i < stringCount; i += 1) {
    let p = offset + stringsStart + stringOffsets[i];
    if (isUtf8) {
      let charLen;
      let byteLen;
      [charLen, p] = readUtf8PoolLen(buf, p);
      [byteLen, p] = readUtf8PoolLen(buf, p);
      void charLen;
      strings.push(buf.subarray(p, p + byteLen).toString('utf8'));
    } else {
      let len = buf.readUInt16LE(p);
      p += 2;
      if (len & 0x8000) {
        len = ((len & 0x7fff) << 16) | buf.readUInt16LE(p);
        p += 2;
      }
      strings.push(buf.subarray(p, p + len * 2).toString('utf16le'));
    }
  }

  return {
    offset,
    headerSize,
    chunkSize,
    stringCount,
    styleCount,
    flags,
    isUtf8,
    stringsStart,
    stylesStart,
    stringOffsets,
    strings,
  };
}

function appendStringsToUtf8Pool(buf, pool, additions) {
  if (!pool.isUtf8) throw new Error('target global string pool is not UTF-8');
  if (pool.flags & SORTED_FLAG) throw new Error('sorted target string pool is not supported');
  const expectedStringsStart = 28 + (pool.stringCount + pool.styleCount) * 4;
  if (pool.stringsStart !== expectedStringsStart) {
    throw new Error(`unexpected stringsStart ${pool.stringsStart} !== ${expectedStringsStart}`);
  }
  const stringsEnd = pool.styleCount > 0 ? pool.stylesStart : pool.chunkSize;
  const oldStringsRaw = buf.subarray(pool.offset + pool.stringsStart, pool.offset + stringsEnd);
  const styleOffsetsRaw = buf.subarray(
    pool.offset + 28 + pool.stringCount * 4,
    pool.offset + 28 + (pool.stringCount + pool.styleCount) * 4,
  );
  const stylesRaw = pool.styleCount > 0
    ? buf.subarray(pool.offset + pool.stylesStart, pool.offset + pool.chunkSize)
    : Buffer.alloc(0);

  const newOffsets = [...pool.stringOffsets];
  const encodedParts = [oldStringsRaw];
  let cursor = oldStringsRaw.length;
  for (const str of additions) {
    newOffsets.push(cursor);
    const utf8 = Buffer.from(str, 'utf8');
    const chunk = Buffer.concat([
      encodeUtf8PoolLen(str.length),
      encodeUtf8PoolLen(utf8.length),
      utf8,
      Buffer.from([0]),
    ]);
    encodedParts.push(chunk);
    cursor += chunk.length;
  }

  const padLen = (4 - (cursor % 4)) % 4;
  if (padLen > 0) encodedParts.push(Buffer.alloc(padLen));
  const paddedStrings = Buffer.concat(encodedParts);

  const newStringCount = pool.stringCount + additions.length;
  const newStringsStart = 28 + (newStringCount + pool.styleCount) * 4;
  const newStylesStart = pool.styleCount > 0 ? newStringsStart + paddedStrings.length : 0;
  const newChunkSize = newStringsStart + paddedStrings.length + stylesRaw.length;

  const header = Buffer.alloc(28);
  header.writeUInt16LE(RES_STRING_POOL_TYPE, 0);
  header.writeUInt16LE(28, 2);
  header.writeUInt32LE(newChunkSize, 4);
  header.writeUInt32LE(newStringCount, 8);
  header.writeUInt32LE(pool.styleCount, 12);
  header.writeUInt32LE(pool.flags, 16);
  header.writeUInt32LE(newStringsStart, 20);
  header.writeUInt32LE(newStylesStart, 24);

  const stringOffsetsBuf = Buffer.alloc(newStringCount * 4);
  for (let i = 0; i < newStringCount; i += 1) {
    stringOffsetsBuf.writeUInt32LE(newOffsets[i], i * 4);
  }
  return Buffer.concat([header, stringOffsetsBuf, styleOffsetsRaw, paddedStrings, stylesRaw]);
}

function listArscPackageChunks(arscBuf) {
  const type = arscBuf.readUInt16LE(0);
  const headerSize = arscBuf.readUInt16LE(2);
  const packageCount = arscBuf.readUInt32LE(8);
  if (type !== RES_TABLE_TYPE || headerSize < 12) {
    throw new Error('invalid resources.arsc header');
  }
  const pool = parseStringPoolChunk(arscBuf, headerSize);
  const pkgs = [];
  let pos = headerSize + pool.chunkSize;
  while (pos + 8 <= arscBuf.length) {
    const ctype = arscBuf.readUInt16LE(pos);
    const csize = arscBuf.readUInt32LE(pos + 4);
    if (csize < 8 || pos + csize > arscBuf.length) {
      throw new Error(`invalid chunk at offset ${pos}`);
    }
    if (ctype === RES_TABLE_PACKAGE_TYPE) {
      const pid = arscBuf.readUInt32LE(pos + 8);
      pkgs.push({ pid, offset: pos, size: csize, chunk: arscBuf.subarray(pos, pos + csize) });
    }
    pos += csize;
  }
  if (pkgs.length !== packageCount) {
    throw new Error(`packageCount mismatch: header=${packageCount}, found=${pkgs.length}`);
  }
  return { headerSize, pool, pkgs };
}

function walkTypeEntries(pkgBuf, onEntry) {
  const pkgHeaderSize = pkgBuf.readUInt16LE(2);
  let pos = pkgHeaderSize;
  while (pos + 8 <= pkgBuf.length) {
    const ctype = pkgBuf.readUInt16LE(pos);
    const cheader = pkgBuf.readUInt16LE(pos + 2);
    const csize = pkgBuf.readUInt32LE(pos + 4);
    if (ctype === RES_TABLE_TYPE_TYPE) {
      const flags = pkgBuf[pos + 10];
      const sparse = Boolean(flags & 1);
      const short = Boolean(flags & 2);
      const entryCount = pkgBuf.readUInt32LE(pos + 12);
      const entriesStart = pos + pkgBuf.readUInt32LE(pos + 16);
      const width = short && !sparse ? 2 : 4;
      for (let i = 0; i < entryCount; i += 1) {
        const offPos = pos + cheader + i * width;
        const entryOff = sparse
          ? pkgBuf.readUInt16LE(offPos + 2) * 4
          : short
            ? (pkgBuf.readUInt16LE(offPos) === 0xffff ? 0xffffffff : pkgBuf.readUInt16LE(offPos) * 4)
            : pkgBuf.readUInt32LE(offPos);
        if (entryOff === 0xffffffff) continue;
        const ep = entriesStart + entryOff;
        const esize = pkgBuf.readUInt16LE(ep);
        const eflags = pkgBuf.readUInt16LE(ep + 2);
        if (eflags & 1) {
          throw new Error(`complex/bag resource entry not supported at offset ${ep}`);
        }
        const compact = Boolean(eflags & 8);
        const valPos = compact ? ep : ep + esize;
        const valType = compact ? (eflags >>> 8) : pkgBuf[valPos + 3];
        const dataPos = compact ? ep + 4 : valPos + 4;
        onEntry(valType, dataPos);
      }
    }
    pos += csize;
  }
}

/**
 * Copy resource packages missing from modArsc (e.g. dynamic feature package 0x81)
 * from stockArsc into modArsc, appending referenced strings to modArsc's global pool.
 */
export function mergeMissingArscPackages(modArsc, stockArsc) {
  const mod = listArscPackageChunks(modArsc);
  const stock = listArscPackageChunks(stockArsc);
  const existingPids = new Set(mod.pkgs.map((p) => p.pid));
  const extraPkgs = stock.pkgs.filter((p) => !existingPids.has(p.pid));
  if (extraPkgs.length === 0) return { arsc: modArsc, addedPackages: [], addedStrings: 0 };

  const stringToModIdx = new Map();
  for (let i = mod.pool.styleCount; i < mod.pool.strings.length; i += 1) {
    if (!stringToModIdx.has(mod.pool.strings[i])) {
      stringToModIdx.set(mod.pool.strings[i], i);
    }
  }

  const additions = [];
  const resolveStringIndex = (str) => {
    const known = stringToModIdx.get(str);
    if (known !== undefined) return known;
    const nextIdx = mod.pool.strings.length + additions.length;
    additions.push(str);
    stringToModIdx.set(str, nextIdx);
    return nextIdx;
  };

  const patchedChunks = extraPkgs.map((pkg) => {
    const copy = Buffer.from(pkg.chunk);
    walkTypeEntries(copy, (valType, dataPos) => {
      if (valType !== TYPE_STRING) return;
      const stockIdx = copy.readUInt32LE(dataPos);
      const str = stock.pool.strings[stockIdx];
      if (str === undefined) {
        throw new Error(`missing stock string pool index ${stockIdx}`);
      }
      copy.writeUInt32LE(resolveStringIndex(str), dataPos);
    });
    return copy;
  });

  const newPoolBuf = appendStringsToUtf8Pool(modArsc, mod.pool, additions);
  const existingPkgsBuf = mod.pkgs.map((p) => p.chunk);
  const tableHeader = Buffer.from(modArsc.subarray(0, mod.headerSize));
  const totalSize = tableHeader.length + newPoolBuf.length
    + existingPkgsBuf.reduce((sum, b) => sum + b.length, 0)
    + patchedChunks.reduce((sum, b) => sum + b.length, 0);
  tableHeader.writeUInt32LE(totalSize, 4);
  tableHeader.writeUInt32LE(mod.pkgs.length + patchedChunks.length, 8);

  return {
    arsc: Buffer.concat([tableHeader, newPoolBuf, ...existingPkgsBuf, ...patchedChunks]),
    addedPackages: extraPkgs.map((p) => `0x${p.pid.toString(16)}`),
    addedStrings: additions.length,
  };
}

export function readZipEntryBytes(apkPath, entryName) {
  const bytes = fs.readFileSync(apkPath);
  const eocdOff = findEocdOffset(bytes);
  const count = bytes.readUInt16LE(eocdOff + 10);
  let cur = bytes.readUInt32LE(eocdOff + 16);
  for (let i = 0; i < count; i += 1) {
    if (bytes.readUInt32LE(cur) !== CD_SIG) throw new Error('invalid zip central directory');
    const method = bytes.readUInt16LE(cur + 10);
    const comp = bytes.readUInt32LE(cur + 20);
    const nlen = bytes.readUInt16LE(cur + 28);
    const extraLen = bytes.readUInt16LE(cur + 30);
    const commentLen = bytes.readUInt16LE(cur + 32);
    const localOff = bytes.readUInt32LE(cur + 42);
    const name = bytes.toString('utf8', cur + 46, cur + 46 + nlen);
    cur += 46 + nlen + extraLen + commentLen;
    if (name !== entryName) continue;
    if (bytes.readUInt32LE(localOff) !== LOCAL_SIG) throw new Error(`bad local header for ${name}`);
    const dataOff = localOff + 30 + bytes.readUInt16LE(localOff + 26) + bytes.readUInt16LE(localOff + 28);
    const payload = bytes.subarray(dataOff, dataOff + comp);
    if (method === 0) return Buffer.from(payload);
    if (method === 8) return inflateRawSync(payload);
    throw new Error(`unsupported zip method ${method} for ${name}`);
  }
  throw new Error(`missing ZIP entry: ${entryName}`);
}

export function replaceZipEntryStored(apkPath, entryName, newBytes) {
  const src = fs.readFileSync(apkPath);
  const eocdOff = findEocdOffset(src);
  const count = src.readUInt16LE(eocdOff + 10);
  let cur = src.readUInt32LE(eocdOff + 16);

  const localParts = [];
  const centralParts = [];
  let writeOffset = 0;
  let replaced = false;

  for (let i = 0; i < count; i += 1) {
    if (src.readUInt32LE(cur) !== CD_SIG) throw new Error('invalid zip central directory');
    const nlen = src.readUInt16LE(cur + 28);
    const cdExtraLen = src.readUInt16LE(cur + 30);
    const cdCommentLen = src.readUInt16LE(cur + 32);
    const cdEntryLen = 46 + nlen + cdExtraLen + cdCommentLen;
    const oldCd = Buffer.from(src.subarray(cur, cur + cdEntryLen));
    const name = src.toString('utf8', cur + 46, cur + 46 + nlen);
    const oldLocalOff = oldCd.readUInt32LE(42);
    const oldCompSize = oldCd.readUInt32LE(20);
    cur += cdEntryLen;

    if (src.readUInt32LE(oldLocalOff) !== LOCAL_SIG) throw new Error(`bad local header for ${name}`);
    const localNameLen = src.readUInt16LE(oldLocalOff + 26);
    const localExtraLen = src.readUInt16LE(oldLocalOff + 28);
    const oldDataOff = oldLocalOff + 30 + localNameLen + localExtraLen;

    if (name === entryName) {
      replaced = true;
      const digest = crc32(newBytes) >>> 0;
      const flags = oldCd.readUInt16LE(8) & ~0x8;
      const localHdr = Buffer.alloc(30);
      localHdr.writeUInt32LE(LOCAL_SIG, 0);
      localHdr.writeUInt16LE(20, 4);
      localHdr.writeUInt16LE(flags, 6);
      localHdr.writeUInt16LE(0, 8);
      localHdr.writeUInt16LE(oldCd.readUInt16LE(12), 10);
      localHdr.writeUInt16LE(oldCd.readUInt16LE(14), 12);
      localHdr.writeUInt32LE(digest, 14);
      localHdr.writeUInt32LE(newBytes.length, 18);
      localHdr.writeUInt32LE(newBytes.length, 22);
      localHdr.writeUInt16LE(nlen, 26);
      localHdr.writeUInt16LE(0, 28);
      const nameBuf = Buffer.from(name, 'utf8');

      oldCd.writeUInt16LE(20, 6);
      oldCd.writeUInt16LE(flags, 8);
      oldCd.writeUInt16LE(0, 10);
      oldCd.writeUInt32LE(digest, 16);
      oldCd.writeUInt32LE(newBytes.length, 20);
      oldCd.writeUInt32LE(newBytes.length, 24);
      oldCd.writeUInt32LE(writeOffset, 42);

      localParts.push(localHdr, nameBuf, newBytes);
      centralParts.push(oldCd);
      writeOffset += localHdr.length + nameBuf.length + newBytes.length;
    } else {
      const localLen = (oldDataOff - oldLocalOff) + oldCompSize;
      const localSlice = Buffer.from(src.subarray(oldLocalOff, oldLocalOff + localLen));
      localSlice.writeUInt16LE(localSlice.readUInt16LE(6) & ~0x8, 6);
      localSlice.writeUInt32LE(oldCd.readUInt32LE(16), 14);
      localSlice.writeUInt32LE(oldCd.readUInt32LE(20), 18);
      localSlice.writeUInt32LE(oldCd.readUInt32LE(24), 22);
      oldCd.writeUInt16LE(oldCd.readUInt16LE(8) & ~0x8, 8);
      oldCd.writeUInt32LE(writeOffset, 42);
      localParts.push(localSlice);
      centralParts.push(oldCd);
      writeOffset += localSlice.length;
    }
  }

  if (!replaced) throw new Error(`missing ZIP entry to replace: ${entryName}`);
  const cdBuf = Buffer.concat(centralParts);
  const eocd = Buffer.alloc(22);
  eocd.writeUInt32LE(EOCD_SIG, 0);
  eocd.writeUInt16LE(count, 8);
  eocd.writeUInt16LE(count, 10);
  eocd.writeUInt32LE(cdBuf.length, 12);
  eocd.writeUInt32LE(writeOffset, 16);
  fs.writeFileSync(apkPath, Buffer.concat([...localParts, cdBuf, eocd]));
}

function findEocdOffset(bytes) {
  for (let i = bytes.length - 22; i >= Math.max(0, bytes.length - 65557); i -= 1) {
    if (bytes.readUInt32LE(i) === EOCD_SIG && i + 22 + bytes.readUInt16LE(i + 20) === bytes.length) {
      return i;
    }
  }
  throw new Error('ZIP end of central directory not found');
}
