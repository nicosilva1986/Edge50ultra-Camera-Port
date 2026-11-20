import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import zlib from 'node:zlib';
import {
  mergeMissingArscPackages,
  readZipEntryBytes,
  replaceZipEntryStored,
} from '../scripts/arsc_merge.mjs';

function encodeUtf8Pool(strings, { styledCount = 0 } = {}) {
  const offsets = [];
  const parts = [];
  let cursor = 0;
  for (const s of strings) {
    offsets.push(cursor);
    const utf8 = Buffer.from(s, 'utf8');
    const cLen = s.length < 0x80 ? Buffer.from([s.length]) : Buffer.from([0x80 | (s.length >> 8), s.length & 0xff]);
    const bLen = utf8.length < 0x80 ? Buffer.from([utf8.length]) : Buffer.from([0x80 | (utf8.length >> 8), utf8.length & 0xff]);
    const item = Buffer.concat([cLen, bLen, utf8, Buffer.from([0])]);
    parts.push(item);
    cursor += item.length;
  }
  const pad = (4 - (cursor % 4)) % 4;
  if (pad) parts.push(Buffer.alloc(pad));
  const stringsBuf = Buffer.concat(parts);
  const styleOffsets = Buffer.alloc(styledCount * 4);
  const stylesBuf = styledCount > 0 ? Buffer.alloc(16, 0xff) : Buffer.alloc(0);
  if (styledCount > 0) {
    styleOffsets.writeUInt32LE(0, 0);
    // Single ResStringPool_span referencing string index 0 ("b") followed by END sentinel (0xffffffff)
    stylesBuf.writeUInt32LE(0, 0);
    stylesBuf.writeUInt32LE(0, 4);
    stylesBuf.writeUInt32LE(3, 8);
    stylesBuf.writeUInt32LE(0xffffffff, 12);
  }
  const stringsStart = 28 + (strings.length + styledCount) * 4;
  const stylesStart = styledCount > 0 ? stringsStart + stringsBuf.length : 0;
  const total = stringsStart + stringsBuf.length + stylesBuf.length;
  const hdr = Buffer.alloc(28);
  hdr.writeUInt16LE(0x0001, 0);
  hdr.writeUInt16LE(28, 2);
  hdr.writeUInt32LE(total, 4);
  hdr.writeUInt32LE(strings.length, 8);
  hdr.writeUInt32LE(styledCount, 12);
  hdr.writeUInt32LE(256, 16);
  hdr.writeUInt32LE(stringsStart, 20);
  hdr.writeUInt32LE(stylesStart, 24);
  const offBuf = Buffer.alloc(strings.length * 4);
  offsets.forEach((v, idx) => offBuf.writeUInt32LE(v, idx * 4));
  return Buffer.concat([hdr, offBuf, styleOffsets, stringsBuf, stylesBuf]);
}

function makeSimplePackage(pid, name, stringIndices) {
  const typesPool = encodeUtf8Pool(['drawable']);
  const keysPool = encodeUtf8Pool(stringIndices.map((_, i) => `k${i}`));
  const hdrSize = 288;
  const header = Buffer.alloc(hdrSize);
  header.writeUInt16LE(0x0200, 0);
  header.writeUInt16LE(hdrSize, 2);
  header.writeUInt32LE(pid, 8);
  Buffer.from(name, 'utf16le').copy(header, 12);
  header.writeUInt32LE(hdrSize, 268);
  header.writeUInt32LE(hdrSize + typesPool.length, 276);

  const n = stringIndices.length;
  const typeHdrSize = 84;
  const offsetsSize = n * 4;
  const entrySize = 16; // 8-byte ResTable_entry + 8-byte Res_value
  const typeSize = typeHdrSize + offsetsSize + n * entrySize;
  const typeChunk = Buffer.alloc(typeSize);
  typeChunk.writeUInt16LE(0x0201, 0);
  typeChunk.writeUInt16LE(typeHdrSize, 2);
  typeChunk.writeUInt32LE(typeSize, 4);
  typeChunk.writeUInt8(1, 8); // id=1 (drawable)
  typeChunk.writeUInt8(0, 9);
  typeChunk.writeUInt16LE(0, 10);
  typeChunk.writeUInt32LE(n, 12);
  typeChunk.writeUInt32LE(typeHdrSize + offsetsSize, 16);
  typeChunk.writeUInt32LE(20, 20); // ResTable_config size=20
  stringIndices.forEach((strIdx, i) => {
    typeChunk.writeUInt32LE(i * entrySize, typeHdrSize + i * 4);
    const ep = typeHdrSize + offsetsSize + i * entrySize;
    typeChunk.writeUInt16LE(8, ep);
    typeChunk.writeUInt16LE(0, ep + 2);
    typeChunk.writeUInt32LE(i, ep + 4);
    typeChunk.writeUInt16LE(8, ep + 8);
    typeChunk.writeUInt8(0, ep + 10);
    typeChunk.writeUInt8(0x03, ep + 11);
    typeChunk.writeUInt32LE(strIdx, ep + 12);
  });

  const full = Buffer.concat([header, typesPool, keysPool, typeChunk]);
  full.writeUInt32LE(full.length, 4);
  return full;
}

function makeArsc(pool, packages) {
  const hdr = Buffer.alloc(12);
  hdr.writeUInt16LE(0x0002, 0);
  hdr.writeUInt16LE(12, 2);
  hdr.writeUInt32LE(packages.length, 8);
  const full = Buffer.concat([hdr, pool, ...packages]);
  full.writeUInt32LE(full.length, 4);
  return full;
}

test('mergeMissingArscPackages appends extra package and rewrites string pool indices preserving styles', () => {
  const modPool = encodeUtf8Pool(['<b>b</b>', 'shared'], { styledCount: 1 });
  const modPkg = makeSimplePackage(0x7f, 'com.motorola.camera3.mod', [1]);
  const modArsc = makeArsc(modPool, [modPkg]);

  const stockPool = encodeUtf8Pool(['unused', 'shared', 'res/drawable/adobe.xml']);
  const stock7f = makeSimplePackage(0x7f, 'com.motorola.camera3', [1]);
  const stock81 = makeSimplePackage(0x81, 'com.motorola.camera3.feature_adobe_scan', [1, 2]);
  const stockArsc = makeArsc(stockPool, [stock7f, stock81]);

  const { arsc, addedPackages, addedStrings } = mergeMissingArscPackages(modArsc, stockArsc);
  assert.deepEqual(addedPackages, ['0x81']);
  assert.equal(addedStrings, 1);
  assert.equal(arsc.readUInt32LE(4), arsc.length);
  assert.equal(arsc.readUInt32LE(8), 2);

  // Idempotent on second run
  const again = mergeMissingArscPackages(arsc, stockArsc);
  assert.deepEqual(again.addedPackages, []);
  assert.equal(again.addedStrings, 0);
  assert.deepEqual(again.arsc, arsc);

  // Independently verify appended 0x81 chunk points to 'shared' (idx 1) and 'res/drawable/adobe.xml' (idx 2)
  const poolSize = arsc.readUInt32LE(12 + 4);
  const stylesStart = arsc.readUInt32LE(12 + 24);
  assert.equal(arsc.readUInt32LE(12 + stylesStart), 0); // style span still points to index 0
  const pkg7fSize = arsc.readUInt32LE(12 + poolSize + 4);
  const pkg81Off = 12 + poolSize + pkg7fSize;
  assert.equal(arsc.readUInt32LE(pkg81Off + 8), 0x81);
  const typeOff = pkg81Off + arsc.readUInt32LE(pkg81Off + 276)
    + arsc.readUInt32LE(pkg81Off + arsc.readUInt32LE(pkg81Off + 276) + 4);
  const entriesStart = typeOff + arsc.readUInt32LE(typeOff + 16);
  assert.equal(arsc.readUInt32LE(entriesStart + 12), 1); // reused 'shared'
  assert.equal(arsc.readUInt32LE(entriesStart + 16 + 12), 2); // appended 'res/drawable/adobe.xml'
});

test('replaceZipEntryStored replaces an entry uncompressed with valid CRC while keeping other entries', () => {
  const root = fs.mkdtempSync(path.join(os.tmpdir(), 'moto-arsc-zip-'));
  const zipPath = path.join(root, 'sample.apk');
  try {
    const entries = [
      { name: 'AndroidManifest.xml', data: Buffer.from('manifest-xml'), method: 8, dataDescriptor: true },
      { name: 'resources.arsc', data: Buffer.from('old-arsc'), method: 0 },
      { name: 'classes.dex', data: Buffer.from('dex-payload-bytes'), method: 8 },
    ];
    const locals = [];
    const centrals = [];
    let offset = 0;
    for (const e of entries) {
      const nameBuf = Buffer.from(e.name, 'utf8');
      const comp = e.method === 8 ? zlib.deflateRawSync(e.data) : e.data;
      const crc = zlib.crc32(e.data) >>> 0;
      const flags = e.dataDescriptor ? 0x0808 : 0;
      const lh = Buffer.alloc(30);
      lh.writeUInt32LE(0x04034b50, 0);
      lh.writeUInt16LE(20, 4);
      lh.writeUInt16LE(flags, 6);
      lh.writeUInt16LE(e.method, 8);
      lh.writeUInt32LE(e.dataDescriptor ? 0 : crc, 14);
      lh.writeUInt32LE(e.dataDescriptor ? 0 : comp.length, 18);
      lh.writeUInt32LE(e.dataDescriptor ? 0 : e.data.length, 22);
      lh.writeUInt16LE(nameBuf.length, 26);
      const dd = e.dataDescriptor ? Buffer.alloc(16) : Buffer.alloc(0);
      if (e.dataDescriptor) {
        dd.writeUInt32LE(0x08074b50, 0);
        dd.writeUInt32LE(crc, 4);
        dd.writeUInt32LE(comp.length, 8);
        dd.writeUInt32LE(e.data.length, 12);
      }
      const ch = Buffer.alloc(46);
      ch.writeUInt32LE(0x02014b50, 0);
      ch.writeUInt16LE(20, 4);
      ch.writeUInt16LE(20, 6);
      ch.writeUInt16LE(flags, 8);
      ch.writeUInt16LE(e.method, 10);
      ch.writeUInt32LE(crc, 16);
      ch.writeUInt32LE(comp.length, 20);
      ch.writeUInt32LE(e.data.length, 24);
      ch.writeUInt16LE(nameBuf.length, 28);
      ch.writeUInt32LE(offset, 42);
      locals.push(lh, nameBuf, comp, dd);
      centrals.push(ch, nameBuf);
      offset += lh.length + nameBuf.length + comp.length + dd.length;
    }
    const cd = Buffer.concat(centrals);
    const eocd = Buffer.alloc(22);
    eocd.writeUInt32LE(0x06054b50, 0);
    eocd.writeUInt16LE(entries.length, 8);
    eocd.writeUInt16LE(entries.length, 10);
    eocd.writeUInt32LE(cd.length, 12);
    eocd.writeUInt32LE(offset, 16);
    fs.writeFileSync(zipPath, Buffer.concat([...locals, cd, eocd]));

    const nextArsc = Buffer.from('merged-resources-arsc-content');
    replaceZipEntryStored(zipPath, 'resources.arsc', nextArsc);
    assert.deepEqual(readZipEntryBytes(zipPath, 'resources.arsc'), nextArsc);
    assert.equal(readZipEntryBytes(zipPath, 'AndroidManifest.xml').toString('utf8'), 'manifest-xml');
    assert.equal(readZipEntryBytes(zipPath, 'classes.dex').toString('utf8'), 'dex-payload-bytes');
    const outZip = fs.readFileSync(zipPath);
    assert.equal(outZip.readUInt16LE(6), 0x0800);
    assert.equal(outZip.readUInt32LE(14), zlib.crc32(Buffer.from('manifest-xml')) >>> 0);
    assert.equal(outZip.readUInt32LE(22), Buffer.from('manifest-xml').length);
  } finally {
    fs.rmSync(root, { recursive: true, force: true });
  }
});
