import { spawnSync } from 'node:child_process';
import { createHash } from 'node:crypto';
import { existsSync, readFileSync, statSync } from 'node:fs';
import { isDeepStrictEqual } from 'node:util';
import path, { resolve } from 'node:path';
import { fileURLToPath, pathToFileURL } from 'node:url';
import { crc32, inflateRawSync } from 'node:zlib';
import { decryptMcf } from './mcf_crypto.mjs';
import { resolveBaseDir, resolveJava, resolveToolJar } from './env_paths.mjs';

const DEFAULT_PACKAGE = 'com.motorola.camera3.mod';
const ANDROID = 'http://schemas.android.com/apk/res/android';
const STOCK = pathToFileURL(resolveBaseDir() + path.sep);
const CONFIGS = ['iq_config_ctwo', 'app_feature_ctwo', 'mcf_config_ctwo'];
const CODEC = new TextDecoder('utf-8', { fatal: true });
const sha256 = bytes => createHash('sha256').update(bytes).digest('hex');
const u16 = (b, p) => b.readUInt16LE(p);
const u32 = (b, p) => b.readUInt32LE(p);

function check(ok, message) {
  if (!ok) throw new Error(message);
}

function within(offset, size, end, label) {
  check(offset >= 0 && size >= 0 && offset <= end && size <= end - offset, 'Invalid ' + label + ' bounds');
}

function zipDirectory(bytes) {
  let end = bytes.length - 22;
  for (; end >= Math.max(0, bytes.length - 65557); end--) {
    if (u32(bytes, end) === 0x06054b50 && end + 22 + u16(bytes, end + 20) === bytes.length) break;
  }
  check(end >= Math.max(0, bytes.length - 65557), 'ZIP end record missing');
  const count = u16(bytes, end + 10);
  const start = u32(bytes, end + 16);
  check(u32(bytes, end + 4) === 0 && u16(bytes, end + 8) === count && count < 0xffff
    && start + u32(bytes, end + 12) === end, 'Unsupported ZIP directory layout');
  const entries = new Map();
  let cursor = start;
  for (let i = 0; i < count; i++) {
    within(cursor, 46, end, 'central directory entry');
    check(u32(bytes, cursor) === 0x02014b50, 'Invalid central directory entry signature');
    const nameLength = u16(bytes, cursor + 28);
    const next = cursor + 46 + nameLength + u16(bytes, cursor + 30) + u16(bytes, cursor + 32);
    within(cursor, next - cursor, end, 'central directory entry');
    const name = CODEC.decode(bytes.subarray(cursor + 46, cursor + 46 + nameLength));
    check(name && !entries.has(name), 'Empty or duplicate ZIP entry: ' + name);
    check(u16(bytes, cursor + 34) === 0, 'ZIP entry is on another disk: ' + name);
    entries.set(name, {
      flags: u16(bytes, cursor + 8),
      method: u16(bytes, cursor + 10),
      crc: u32(bytes, cursor + 16),
      compressed: u32(bytes, cursor + 20),
      size: u32(bytes, cursor + 24),
      offset: u32(bytes, cursor + 42),
    });
    cursor = next;
  }
  check(cursor === end, 'Unexpected central directory bytes');
  return { start, entries };
}

function signingBlock(bytes, directoryStart) {
  const footer = directoryStart - 24;
  if (footer < 0 || bytes.toString('ascii', footer + 8, directoryStart) !== 'APK Sig Block 42') {
    return { start: directoryStart, schemes: [] };
  }
  const size = Number(bytes.readBigUInt64LE(footer));
  const start = directoryStart - size - 8;
  check(Number.isSafeInteger(size) && size >= 24 && start >= 0
    && bytes.readBigUInt64LE(start) === BigInt(size), 'Invalid APK signing block size');
  const known = new Map([[0x7109871a, 'v2'], [0xf05368c0, 'v3'], [0x1b93ad61, 'v3.1']]);
  const schemes = new Set();
  for (let cursor = start + 8; cursor < footer;) {
    within(cursor, 12, footer, 'APK signing block pair');
    const length = Number(bytes.readBigUInt64LE(cursor));
    check(Number.isSafeInteger(length) && length >= 4, 'Invalid APK signing block pair length');
    within(cursor + 8, length, footer, 'APK signing block value');
    const scheme = known.get(u32(bytes, cursor + 8));
    if (scheme) {
      check(length > 4 && !schemes.has(scheme), 'Invalid or duplicate signature scheme ' + scheme);
      schemes.add(scheme);
    }
    cursor += 8 + length;
  }
  return { start, schemes: [...schemes].sort() };
}

function zipEntry(bytes, entry, name, end, limit) {
  check(entry, 'Missing ZIP entry: ' + name);
  const { offset, method, flags, compressed, size, crc } = entry;
  check(!(flags & 1) && (method === 0 || method === 8) && size <= limit, 'Unsupported ZIP entry: ' + name);
  within(offset, 30, end, 'local ZIP header for ' + name);
  check(u32(bytes, offset) === 0x04034b50 && u16(bytes, offset + 6) === flags
    && u16(bytes, offset + 8) === method, 'Local and central ZIP headers disagree: ' + name);
  const nameLength = u16(bytes, offset + 26);
  const dataOffset = offset + 30 + nameLength + u16(bytes, offset + 28);
  within(offset + 30, dataOffset - offset - 30 + compressed, end, 'ZIP data for ' + name);
  check(CODEC.decode(bytes.subarray(offset + 30, offset + 30 + nameLength)) === name,
    'Local and central ZIP entry names disagree: ' + name);
  const data = bytes.subarray(dataOffset, dataOffset + compressed);
  const plain = method === 0 ? data : inflateRawSync(data, { maxOutputLength: Math.max(1, size) });
  check(plain.length === size && crc32(plain) === crc, 'ZIP entry length or CRC mismatch: ' + name);
  return plain;
}

function chunk(bytes, start, end) {
  within(start, 8, end, 'Android chunk header');
  const type = u16(bytes, start);
  const header = u16(bytes, start + 2);
  const size = u32(bytes, start + 4);
  check(header >= 8 && size >= header, 'Invalid Android chunk sizes');
  within(start, size, end, 'Android chunk');
  return { type, header, start, end: start + size };
}

function* children(bytes, parent) {
  for (let cursor = parent.start + parent.header; cursor < parent.end;) {
    const child = chunk(bytes, cursor, parent.end);
    yield child;
    cursor = child.end;
  }
}

function stringPool(bytes, pool) {
  check(pool.type === 1 && pool.header >= 28, 'Missing Android string pool');
  const { start, end, header } = pool;
  const count = u32(bytes, start + 8);
  const utf8 = Boolean(u32(bytes, start + 16) & 0x100);
  const first = start + u32(bytes, start + 20);
  within(start + header, count * 4, first, 'Android string offsets');
  within(first, 0, end, 'Android string data');
  const cache = new Map();
  const length = pos => {
    const unit = utf8 ? 1 : 2;
    within(pos, unit, end, 'Android string length');
    const initial = utf8 ? bytes[pos] : u16(bytes, pos);
    const high = utf8 ? 128 : 32768;
    if (initial < high) return [initial, pos + unit];
    within(pos, 2 * unit, end, 'extended Android string length');
    const next = utf8 ? bytes[pos + unit] : u16(bytes, pos + unit);
    return [(initial - high) * (utf8 ? 256 : 65536) + next, pos + 2 * unit];
  };
  return index => {
    if (index === 0xffffffff) return null;
    check(index < count, 'Android string index is out of range');
    if (cache.has(index)) return cache.get(index);
    let [size, pos] = length(first + u32(bytes, start + header + index * 4));
    if (utf8) [size, pos] = length(pos);
    const byteSize = utf8 ? size : size * 2;
    within(pos, byteSize + (utf8 ? 1 : 2), end, 'Android string');
    check((utf8 ? bytes[pos + byteSize] : u16(bytes, pos + byteSize)) === 0, 'Unterminated Android string');
    const value = utf8 ? CODEC.decode(bytes.subarray(pos, pos + size))
      : bytes.toString('utf16le', pos, pos + byteSize);
    cache.set(index, value);
    return value;
  };
}

function typedValue(bytes, pos, end, strings) {
  within(pos, 8, end, 'Android typed value');
  check(u16(bytes, pos) === 8 && bytes[pos + 2] === 0, 'Invalid Android typed value');
  return valueOf(bytes[pos + 3], u32(bytes, pos + 4), strings);
}

function valueOf(type, data, strings) {
  if (type === 3) return strings(data);
  if (type === 0x12) return Boolean(data);
  return { type, data };
}

export function decodeManifest(bytes) {
  const root = chunk(bytes, 0, bytes.length);
  check(root.type === 3 && root.end === bytes.length, 'Expected binary AndroidManifest.xml');
  let strings;
  let manifest;
  const stack = [];
  for (const part of children(bytes, root)) {
    const { type, start, header, end } = part;
    if (type === 1) {
      check(!strings, 'Duplicate manifest string pool');
      strings = stringPool(bytes, part);
    }
    if (type !== 0x0102 && type !== 0x0103) continue;
    check(strings && header >= 16, 'Invalid AXML element header');
    const ext = start + header;
    within(ext, type === 0x0102 ? 20 : 8, end, 'AXML element');
    const ns = strings(u32(bytes, ext));
    const name = strings(u32(bytes, ext + 4));
    check(name, 'AXML element without a name');
    if (type === 0x0103) {
      const element = stack.pop();
      check(element?.name === name && element.ns === ns, 'Mismatched AXML end element');
      continue;
    }
    const first = u16(bytes, ext + 8);
    const width = u16(bytes, ext + 10);
    const count = u16(bytes, ext + 12);
    check(first >= 20 && width >= 20, 'Invalid AXML attributes layout');
    within(ext + first, width * count, end, 'AXML attributes');
    const attrs = new Map();
    for (let i = 0; i < count; i++) {
      const pos = ext + first + i * width;
      const key = (strings(u32(bytes, pos)) ?? '') + '|' + strings(u32(bytes, pos + 4));
      check(!attrs.has(key), 'Duplicate AXML attribute: ' + key);
      attrs.set(key, typedValue(bytes, pos + 12, end, strings));
    }
    const element = { name, ns, attrs, children: [] };
    if (stack.length) stack.at(-1).children.push(element);
    else {
      check(!manifest, 'More than one AXML root element');
      manifest = element;
    }
    stack.push(element);
  }
  check(manifest?.name === 'manifest' && !manifest.ns && stack.length === 0, 'Invalid AXML manifest root');
  return manifest;
}

function resourceStrings(bytes) {
  const root = chunk(bytes, 0, bytes.length);
  check(root.type === 2 && root.header >= 12 && root.end === bytes.length, 'Invalid resources.arsc header');
  let strings;
  let packageCount = 0;
  const byId = new Map();
  const authorityIds = new Set();

  for (const pkg of children(bytes, root)) {
    if (pkg.type === 1) {
      check(!strings, 'Duplicate global resource string pool');
      strings = stringPool(bytes, pkg);
    }
    if (pkg.type !== 0x0200) continue;
    packageCount++;
    check(strings && pkg.header >= 284, 'Invalid Android resource package');
    const pid = u32(bytes, pkg.start + 8);
    const types = stringPool(bytes, chunk(bytes, pkg.start + u32(bytes, pkg.start + 268), pkg.end));
    const names = stringPool(bytes, chunk(bytes, pkg.start + u32(bytes, pkg.start + 276), pkg.end));
    const typeOffset = pkg.header >= 288 ? u32(bytes, pkg.start + 284) : 0;

    for (const table of children(bytes, pkg)) {
      if (table.type !== 0x0201) continue;
      check(table.header >= 24, 'Invalid Android resource type header');
      const tid = bytes[table.start + 8];
      check(pid <= 255 && tid > 0 && tid + typeOffset <= 255, 'Invalid Android resource package or type ID');
      const typeName = types(tid - 1);
      if (typeName !== 'string' && typeName !== 'bool') continue;
      const flags = bytes[table.start + 9];
      check(flags <= 3, 'Unsupported Android resource entry offsets');
      const sparse = Boolean(flags & 1);
      const short = Boolean(flags & 2);
      const count = u32(bytes, table.start + 12);
      const entries = table.start + u32(bytes, table.start + 16);
      const width = short && !sparse ? 2 : 4;
      within(table.start + table.header, count * width, entries, 'Android resource offsets');
      within(entries, 0, table.end, 'Android resource entries');
      for (let i = 0; i < count; i++) {
        const p = table.start + table.header + i * width;
        const index = sparse ? u16(bytes, p) : i;
        const offset = sparse ? u16(bytes, p + 2) * 4
          : short ? (u16(bytes, p) === 0xffff ? 0xffffffff : u16(bytes, p) * 4)
            : u32(bytes, p);
        if (offset === 0xffffffff) continue;
        check(index <= 0xffff, 'Invalid Android resource entry ID');
        const start = entries + offset;
        within(start, 8, table.end, 'Android resource entry');
        const entryFlags = u16(bytes, start + 2);
        if (entryFlags & 1) continue;
        const compact = Boolean(entryFlags & 8);
        const id = ((pid << 24) | ((tid + typeOffset) << 16) | index) >>> 0;
        const name = names(compact ? u16(bytes, start) : u32(bytes, start + 4));
        const size = u16(bytes, start);
        check(compact || size >= 8, 'Invalid Android resource entry length');
        const value = compact ? valueOf(entryFlags >>> 8, u32(bytes, start + 4), strings)
          : typedValue(bytes, start + size, table.end, strings);
        if (!byId.has(id)) byId.set(id, new Set());
        byId.get(id).add(value);
        if (typeName === 'string' && name === 'provider_authority') authorityIds.add(id);
      }
    }
  }
  check(strings && packageCount > 0 && packageCount === u32(bytes, 8), 'Invalid Android resource package count');

  function values(value, chain = new Set()) {
    if (typeof value === 'string' || typeof value === 'boolean') return [value];
    const id = value?.data;
    check(value?.type === 1 && byId.has(id) && !chain.has(id),
      'Unresolved or cyclic Android resource ' + (id === undefined ? '' : '0x' + id.toString(16)));
    const next = new Set(chain).add(id);
    return [...new Set([...byId.get(id)].flatMap(entry => values(entry, next)))];
  }
  return { values, authorityIds };
}

function inspectManifest(manifest, resources, expected) {
  const android = (node, key) => node.attrs.get(ANDROID + '|' + key);
  const select = (node, name) => node.children.filter(item => item.name === name && !item.ns);
  const packageName = manifest.attrs.get('|package');
  const gate = (pass, details) => ({ pass, ...details });
  const applications = select(manifest, 'application');
  check(applications.length === 1, 'Expected one manifest application');
  const [app] = applications;
  const resolve = (value, type) => {
    try {
      const resolved = resources.values(value);
      check(resolved.length && resolved.every(item => typeof item === type), 'Expected Android ' + type);
      return { values: resolved.sort(), error: null };
    } catch (error) {
      return { values: [], error: error.message };
    }
  };
  const named = (node, name) => resolve(android(node, name), 'string');
  const isolated = value => value.split(';').every(authority => {
    const name = authority.trim();
    return name === expected || name.startsWith(expected + '.');
  });
  const permissions = select(manifest, 'permission').map(item => named(item, 'name'));
  const providers = select(app, 'provider').map(item => {
    const id = named(item, 'name');
    return { name: id.values[0] ?? null, ...named(item, 'authorities') };
  });
  const providerAuthorityStrings = [...resources.authorityIds].map(data =>
    resolve({ type: 1, data }, 'string'),
  );
  const libraries = select(app, 'uses-library').map(item => {
    const name = named(item, 'name');
    const required = android(item, 'required');
    return { name, required };
  });
  const moto = libraries.filter(item => item.name.values.includes('com.motorola.motosignature')).map(item =>
    item.required === undefined ? { values: [true], error: null } : resolve(item.required, 'boolean'),
  );
  const label = named(app, 'label');
  const badPermissions = permissions.filter(item =>
    item.error || item.values.includes('com.motorola.camera.permission.CONTROL_CAMERA'),
  );

  return {
    package: gate(packageName === expected, { expected, actual: typeof packageName === 'string' ? packageName : null }),
    permissionIsolation: gate(!badPermissions.length, { collisions: badPermissions }),
    providerIsolation: gate([...providers, ...providerAuthorityStrings].every(item =>
      !item.error && item.values.every(isolated)), { providers, providerAuthorityStrings }),
    motoSignatureOptional: gate(libraries.every(item => !item.name.error)
      && moto.every(item => !item.error && item.values.every(value => value === false)), { declarations: moto }),
    appLabel: gate(
      !label.error && label.values.every(value => (
        expected === DEFAULT_PACKAGE ? value === 'MotoCam Mod' : value.trim().length > 0
      )),
      label,
    ),
  };
}

function parseConfig(name, bytes) {
  const json = JSON.parse(CODEC.decode(bytes));
  const object = value => value !== null && typeof value === 'object' && !Array.isArray(value);
  if (name === 'app_feature_ctwo') {
    check(object(json) && json.d === 'ctwo' && Array.isArray(json.fs), 'Invalid ctwo feature config shape');
  } else {
    check(object(json) && object(json.ctwo), 'Invalid ctwo config shape');
  }
  return json;
}

// Equal prefixes/suffixes anchor arrays. Remaining paired slots are compared in
// order. An added or removed subtree counts once at its first missing path.
function diffCounts(stock, actual) {
  const counts = { added: 0, removed: 0, changed: 0, total: 0 };
  function visit(a, b) {
    if (Object.is(a, b)) return;
    if (Array.isArray(a) && Array.isArray(b)) {
      let front = 0;
      let leftEnd = a.length;
      let rightEnd = b.length;
      while (front < leftEnd && front < rightEnd && isDeepStrictEqual(a[front], b[front])) front++;
      while (front < leftEnd && front < rightEnd && isDeepStrictEqual(a[leftEnd - 1], b[rightEnd - 1])) {
        leftEnd--;
        rightEnd--;
      }
      for (let i = front; i < Math.min(leftEnd, rightEnd); i++) visit(a[i], b[i]);
      counts.added += Math.max(0, rightEnd - leftEnd);
      counts.removed += Math.max(0, leftEnd - rightEnd);
    } else if (a !== null && b !== null && typeof a === 'object' && typeof b === 'object'
      && !Array.isArray(a) && !Array.isArray(b)) {
      for (const key of Object.keys(a)) {
        if (Object.hasOwn(b, key)) visit(a[key], b[key]);
        else counts.removed++;
      }
      for (const key of Object.keys(b)) if (!Object.hasOwn(a, key)) counts.added++;
    } else {
      counts.changed++;
    }
  }
  visit(stock, actual);
  counts.total = counts.added + counts.removed + counts.changed;
  return counts;
}

export function inspectApk(bytes, stockConfigs, expectedPackage = DEFAULT_PACKAGE) {
  const MiB = 1024 * 1024;
  const attempt = fn => {
    try { return { pass: true, ...fn() }; }
    catch (error) { return { pass: false, error: error.message }; }
  };
  const { start, entries } = zipDirectory(bytes);
  const block = signingBlock(bytes, start);
  const get = (name, limit) => zipEntry(bytes, entries.get(name), name, block.start, limit);
  const dex = [...entries.keys()].filter(name => /^classes(?:[2-9]|[1-9][0-9]+)?\.dex$/.test(name)).sort();
  const arm64 = [...entries.keys()].filter(name => /^lib\/arm64-v8a\/[^/]+\.so$/.test(name)).sort();
  const archive = attempt(() => {
    check(dex.includes('classes.dex'), 'Missing classes.dex');
    check(arm64.length > 0, 'Missing arm64-v8a native libraries');
    for (const name of dex) {
      const header = get(name, 128 * MiB).toString('latin1', 0, 8);
      check(/^dex\n(?:035|037|038|039|040|041)\0$/.test(header), 'Invalid DEX magic: ' + name);
    }
    for (const name of arm64) {
      const elf = get(name, 128 * MiB);
      const isElf = elf.length >= 52 && elf.subarray(0, 4).equals(Buffer.from([0x7f, 0x45, 0x4c, 0x46])) && elf[5] === 1;
      const isArm64 = isElf && elf.length >= 64 && elf[4] === 2 && u16(elf, 18) === 183;
      const isQdsp6Skel = isElf && /_skel\.so$/i.test(name) && elf[4] === 1 && u16(elf, 18) === 164;
      check(isArm64 || isQdsp6Skel, 'Invalid ARM64/DSP ELF: ' + name);
    }
    return { dex, arm64 };
  });
  const manifest = attempt(() => {
    const tree = decodeManifest(get('AndroidManifest.xml', 8 * MiB));
    const resources = resourceStrings(get('resources.arsc', 64 * MiB));
    const checks = inspectManifest(tree, resources, expectedPackage);
    return { checks, pass: Object.values(checks).every(result => result.pass) };
  });
  const configs = Object.fromEntries(CONFIGS.map(name => [name, attempt(() => {
    const data = get('assets/' + name, 8 * MiB);
    const plain = name === 'mcf_config_ctwo' ? decryptMcf(data) : data;
    const actual = parseConfig(name, plain);
    const reference = parseConfig(name, stockConfigs[name]);
    return { sha256: sha256(data), diff: diffCounts(reference, actual) };
  })]));

  return { archive, manifest, configs, signingBlockSchemes: block.schemes };
}

function verifySignature(apk, digest, present) {
  const java = resolveJava(process.env.MOTO_QA_JAVA);
  const signer = resolveToolJar(null, 'UBER_APK_SIGNER_JAR', 'uber-apk-signer.jar');
  const run = spawnSync(java, ['-jar', signer, '--onlyVerify', '--skipZipAlign', '--apks', apk], {
    encoding: 'utf8',
    timeout: 120000,
    windowsHide: true,
  });
  const output = run.stdout ?? '';
  const verified = output.match(/^\s*-\s*signature verified \[([^\]\r\n]+)\]/m);
  const schemes = verified ? [...new Set(verified[1].match(/\bv\d+(?:\.\d+)?\b/g) ?? [])].sort() : [];
  const verifiedHash = output.match(/^\s*checksum:\s*([a-f0-9]{64})\s+\(sha256\)/im)?.[1].toLowerCase();
  const certificates = [...output.matchAll(/^\s*SHA256:\s*([a-f0-9]{64})\s*\/[^\r\n]+/gim)]
    .map(match => match[1].toLowerCase()).sort();
  const modern = schemes.some(scheme => ['v2', 'v3', 'v3.1'].includes(scheme) && present.includes(scheme));
  const clean = run.status === 0 && /Successfully processed 1 APKs and 0 errors\b/.test(output);
  const pass = clean && verifiedHash === digest && certificates.length > 0 && modern;
  return {
    pass, tool: 'uber-apk-signer', exitCode: run.status, verifiedSchemes: schemes, certificates,
    error: pass ? null : run.error?.code
      ?? (!clean ? 'Signature verification failed' : !modern ? 'No verified v2/v3 signing scheme'
        : verifiedHash !== digest ? 'Signer checksum differs from inspected APK' : 'Signer certificate fingerprint missing'),
  };
}

function cli(args) {
  const options = { json: false, expected: DEFAULT_PACKAGE };
  for (let i = 0; i < args.length; i++) {
    const arg = args[i];
    if (arg === '--json') options.json = true;
    else if (arg === '--apk' || arg === '--expect-package') {
      const value = args[++i];
      check(value && !value.startsWith('--'), 'Missing value for ' + arg);
      options[arg === '--apk' ? 'apk' : 'expected'] = value;
    } else throw new Error('Unknown argument: ' + arg);
  }
  check(options.apk && /^[A-Za-z_]\w*(?:\.[A-Za-z_]\w*)+$/.test(options.expected),
    'Usage: node scripts/verify_apk.mjs --apk <path> [--json] [--expect-package <pkg>]');
  const apk = resolve(options.apk);
  const report = { pass: false, expectedPackage: options.expected };
  try {
    check(statSync(apk).isFile(), 'APK input must be a single regular file');
    const bytes = readFileSync(apk);
    const digest = sha256(bytes);
    report.sha256 = digest;
    const stockConfigs = Object.fromEntries(CONFIGS.map(name => [
      name, readFileSync(new URL('configs/' + name + (name === 'mcf_config_ctwo' ? '.decrypted.json' : ''), STOCK)),
    ]));
    Object.assign(report, inspectApk(bytes, stockConfigs, options.expected));
    report.signature = verifySignature(apk, digest, report.signingBlockSchemes);
    report.pass = report.archive.pass && report.manifest.pass && report.signature.pass
      && Object.values(report.configs).every(config => config.pass);
  } catch (error) {
    report.error = error.code ?? error.message;
  }
  if (!options.json) console.log(report.pass ? 'APK verification passed' : 'APK verification failed');
  console.log(JSON.stringify(report, null, 2));
  return report.pass ? 0 : 1;
}

if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) {
  try {
    process.exitCode = cli(process.argv.slice(2));
  } catch (error) {
    console.error(error.message);
    process.exitCode = 2;
  }
}
