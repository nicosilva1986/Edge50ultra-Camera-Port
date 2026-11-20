import { spawnSync } from 'node:child_process';
import fs from 'node:fs';
import path from 'node:path';
import zlib from 'node:zlib';
import { fileURLToPath } from 'node:url';
import {
  mergeMissingArscPackages,
  readZipEntryBytes,
  replaceZipEntryStored,
} from './arsc_merge.mjs';

import {
  REPO_ROOT,
  resolveBaseDir,
  resolveJava,
  resolveToolJar,
} from './env_paths.mjs';

const BASE_DIR = resolveBaseDir();
const JAVA = resolveJava();
const APKTOOL = resolveToolJar(null, 'APKTOOL_JAR', 'apktool3.jar');
const SIGNER = resolveToolJar(null, 'UBER_APK_SIGNER_JAR', 'uber-apk-signer.jar');

const DEFAULT_SOURCE = path.join(BASE_DIR, 'decompiled', 'MotCamera4_v3');
const DEFAULT_STAGE = path.join(BASE_DIR, 'work_clone');
const DEFAULT_OUT = path.join(BASE_DIR, 'dist', 'MotCamera4-Mod.apk');

const STOCK_PACKAGE = 'com.motorola.camera3';
const MOD_PACKAGE = 'com.motorola.camera3.mod';
const CONTROL_CAMERA = 'com.motorola.camera.permission.CONTROL_CAMERA';
const DYNAMIC_RECEIVER = 'com.motorola.camera3.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION';
const DYNAMIC_RECEIVER_MOD = 'com.motorola.camera3.mod.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION';
const PROVIDER_AUTHORITY = 'com.motorola.camera3.provider.photos.specialtype';
const PROVIDER_AUTHORITY_MOD = 'com.motorola.camera3.mod.provider.photos.specialtype';
const EXTERNAL_AI_AUTHORITY = 'com.motorola.camera3.content.ai';
const APP_LABEL = 'MotoCam Mod';

const EOCD_SIG = 0x06054b50;
const CD_SIG = 0x02014b50;
const LOCAL_SIG = 0x04034b50;

export function parseArgs(argv) {
  const opts = {
    source: DEFAULT_SOURCE,
    stageDir: DEFAULT_STAGE,
    out: DEFAULT_OUT,
    patches: null,
    configsDir: null,
    extraSmali: [],
    bundleAiApk: null,
    mergeArscFrom: null,
    dryRun: false,
    help: false,
  };
  for (let i = 0; i < argv.length; i += 1) {
    const arg = argv[i];
    const take = () => {
      const value = argv[i + 1];
      if (value === undefined || value.startsWith('--')) {
        throw new Error(`missing value for ${arg}`);
      }
      i += 1;
      return value;
    };
    if (arg === '--help' || arg === '-h') opts.help = true;
    else if (arg === '--dry-run') opts.dryRun = true;
    else if (arg === '--source') opts.source = take();
    else if (arg.startsWith('--source=')) opts.source = arg.slice('--source='.length);
    else if (arg === '--stage-dir') opts.stageDir = take();
    else if (arg.startsWith('--stage-dir=')) opts.stageDir = arg.slice('--stage-dir='.length);
    else if (arg === '--out') opts.out = take();
    else if (arg.startsWith('--out=')) opts.out = arg.slice('--out='.length);
    else if (arg === '--patches') opts.patches = take();
    else if (arg.startsWith('--patches=')) opts.patches = arg.slice('--patches='.length);
    else if (arg === '--configs-dir') opts.configsDir = take();
    else if (arg.startsWith('--configs-dir=')) opts.configsDir = arg.slice('--configs-dir='.length);
    else if (arg === '--extra-smali') opts.extraSmali.push(take());
    else if (arg.startsWith('--extra-smali=')) opts.extraSmali.push(arg.slice('--extra-smali='.length));
    else if (arg === '--bundle-ai-apk') opts.bundleAiApk = take();
    else if (arg.startsWith('--bundle-ai-apk=')) opts.bundleAiApk = arg.slice('--bundle-ai-apk='.length);
    else if (arg === '--merge-arsc-from') opts.mergeArscFrom = take();
    else if (arg.startsWith('--merge-arsc-from=')) opts.mergeArscFrom = arg.slice('--merge-arsc-from='.length);
    else throw new Error(`unknown argument ${arg}`);
  }
  return opts;
}

export function transformManifest(xml) {
  const queries = [];
  let next = xml.replace(/<queries\b[^>]*>[\s\S]*?<\/queries>/g, (block) => {
    const token = `\u0000Q${queries.length}\u0000`;
    queries.push(block);
    return token;
  });
  next = next.split('package="com.motorola.camera3"').join('package="com.motorola.camera3.mod"');
  next = next.split(DYNAMIC_RECEIVER).join(DYNAMIC_RECEIVER_MOD);
  next = removeControlCameraDeclaration(next);
  next = next.replace(/[ \t]+android:permission="com\.motorola\.camera\.permission\.CONTROL_CAMERA"/g, '');
  next = renameOwnedAuthorities(next);
  next = relaxMotoSignature(next);
  queries.forEach((block, index) => {
    const token = `\u0000Q${index}\u0000`;
    if (!next.includes(token)) throw new Error('queries block was lost during manifest transform');
    next = next.replace(token, block);
  });
  assertManifestCloned(next);
  return next;
}

export function transformStrings(xml) {
  const labeled = xml.replace(
    /(<string\b[^>]*\bname="act_name_camera"[^>]*>)([\s\S]*?)(<\/string>)/g,
    `$1${APP_LABEL}$3`,
  );
  return labeled.replace(
    /(<string\b[^>]*\bname="provider_authority"[^>]*>)([\s\S]*?)(<\/string>)/g,
    (all, open, value, close) => `${open}${value.split(PROVIDER_AUTHORITY).join(PROVIDER_AUTHORITY_MOD)}${close}`,
  );
}

export function stageCloneTexts(sourceDir, stageDir, { allLocales }) {
  const manifest = transformManifest(readUtf8(path.join(sourceDir, 'AndroidManifest.xml')));
  writeUtf8(path.join(stageDir, 'AndroidManifest.xml'), manifest);
  const rels = allLocales ? listLocaleStringRels(sourceDir) : ['res/values/strings.xml'];
  if (!rels.includes('res/values/strings.xml')) {
    throw new Error(`source is missing res/values/strings.xml: ${sourceDir}`);
  }
  for (const rel of rels) {
    const inputPath = safeJoin(sourceDir, rel);
    const input = readUtf8(inputPath);
    const output = transformStrings(input);
    assertStringsCloned(rel, input, output);
    writeUtf8(safeJoin(stageDir, rel), output);
  }
  return rels;
}

export function loadPatches(file) {
  let raw = readUtf8(file);
  if (raw.charCodeAt(0) === 0xfeff) raw = raw.slice(1);
  const rawJson = JSON.parse(raw);
  const data = Array.isArray(rawJson) ? rawJson : rawJson?.patches;
  if (!Array.isArray(data)) throw new Error('patches file must be a JSON array or { patches: [...] }');
  return data.map((item, index) => {
    if (item === null || typeof item !== 'object' || Array.isArray(item)) {
      throw new Error(`patch ${index} must be an object`);
    }
    if (typeof item.id !== 'string' || item.id.length === 0) {
      throw new Error(`patch ${index} id must be a non-empty string`);
    }
    if (typeof item.file !== 'string' || item.file.length === 0) {
      throw new Error(`patch ${item.id} file must be a non-empty string`);
    }
    if (typeof item.find !== 'string' || item.find.length === 0) {
      throw new Error(`patch ${item.id} find must be a non-empty string`);
    }
    if (typeof item.replace !== 'string') throw new Error(`patch ${item.id} replace must be a string`);
    if (item.optional !== undefined && typeof item.optional !== 'boolean') {
      throw new Error(`patch ${item.id} optional must be a boolean`);
    }
    return {
      id: item.id,
      file: normalizeRel(item.file),
      find: item.find,
      replace: item.replace,
      optional: item.optional === true,
    };
  });
}

export function extractAssetBins(apkPath, outputDir) {
  const fd = fs.openSync(apkPath, 'r');
  try {
    const size = fs.fstatSync(fd).size;
    const eocd = readEocd(fd, size);
    if (eocd.cdOffset === 0xffffffff || eocd.cdSize === 0xffffffff) {
      throw new Error('ZIP64 archives are not supported');
    }
    const cd = Buffer.alloc(eocd.cdSize);
    if (fs.readSync(fd, cd, 0, eocd.cdSize, eocd.cdOffset) !== eocd.cdSize) {
      throw new Error('truncated zip central directory');
    }
    const extracted = [];
    let offset = 0;
    while (offset + 46 <= cd.length && cd.readUInt32LE(offset) === CD_SIG) {
      const flags = cd.readUInt16LE(offset + 8);
      const method = cd.readUInt16LE(offset + 10);
      const compSize = cd.readUInt32LE(offset + 20);
      const uncompSize = cd.readUInt32LE(offset + 24);
      const nameLen = cd.readUInt16LE(offset + 28);
      const extraLen = cd.readUInt16LE(offset + 30);
      const commentLen = cd.readUInt16LE(offset + 32);
      const localOff = cd.readUInt32LE(offset + 42);
      const name = cd.slice(offset + 46, offset + 46 + nameLen).toString('utf8');
      offset += 46 + nameLen + extraLen + commentLen;
      if (!isAssetBin(name)) continue;
      if ((flags & 1) !== 0) throw new Error(`encrypted zip entry ${name}`);
      if (localOff === 0xffffffff || compSize === 0xffffffff || uncompSize === 0xffffffff) {
        throw new Error(`ZIP64 entry is not supported: ${name}`);
      }
      const local = Buffer.alloc(30);
      if (fs.readSync(fd, local, 0, 30, localOff) !== 30) throw new Error(`truncated local header for ${name}`);
      if (local.readUInt32LE(0) !== LOCAL_SIG) throw new Error(`bad local header for ${name}`);
      const dataOff = localOff + 30 + local.readUInt16LE(26) + local.readUInt16LE(28);
      const compressed = Buffer.alloc(compSize);
      if (fs.readSync(fd, compressed, 0, compSize, dataOff) !== compSize) {
        throw new Error(`truncated zip entry ${name}`);
      }
      let data;
      if (method === 0) data = compressed;
      else if (method === 8) data = zlib.inflateRawSync(compressed);
      else throw new Error(`unsupported zip method ${method} for ${name}`);
      if (data.length !== uncompSize) throw new Error(`size mismatch for ${name}`);
      const rel = name.slice('assets/'.length);
      const dest = safeJoin(outputDir, rel);
      fs.mkdirSync(path.dirname(dest), { recursive: true });
      fs.writeFileSync(dest, data);
      extracted.push(rel);
    }
    extracted.sort((a, b) => a.localeCompare(b));
    return extracted;
  } finally {
    fs.closeSync(fd);
  }
}

// uber-apk-signer 1.3.0 with --overwrite zipaligns, then signs the input path in place.
// Without --overwrite the signed file is <basename>-aligned-debugSigned.apk. Accept either.
export function publishSignedApk(outDir, unsignedPath, finalPath) {
  const signedPath = findSignedApk(outDir, unsignedPath);
  if (signedPath === null) {
    const seen = fs.existsSync(outDir) ? fs.readdirSync(outDir).join(', ') : '(missing out dir)';
    throw new Error(`signed apk not found for ${path.basename(unsignedPath)}; out dir has ${seen}`);
  }
  fs.mkdirSync(path.dirname(finalPath), { recursive: true });
  if (path.resolve(signedPath) !== path.resolve(finalPath)) {
    fs.rmSync(finalPath, { force: true });
    fs.renameSync(signedPath, finalPath);
  }
  const unsignedBase = path.basename(unsignedPath, '.apk');
  const finalName = path.basename(finalPath);
  for (const name of fs.readdirSync(outDir)) {
    if (name === finalName) continue;
    if (name === `${finalName}.idsig`) continue;
    if (name.startsWith(unsignedBase)) fs.rmSync(path.join(outDir, name), { force: true });
  }
  return finalPath;
}

export function runPipeline(options) {
  const sourceDir = path.resolve(options.source);
  const stageDir = path.resolve(options.stageDir);
  const outApk = path.resolve(options.out);
  if (options.help) {
    printHelp();
    return { help: true };
  }
  assertStageAllowed(sourceDir, stageDir);
  if (!options.dryRun) assertOutsideRepo(outApk, '--out');
  assertDirectory(sourceDir, 'source');
  if (!fs.existsSync(path.join(sourceDir, 'AndroidManifest.xml'))) {
    throw new Error(`source has no AndroidManifest.xml: ${sourceDir}`);
  }
  if (!fs.existsSync(path.join(sourceDir, 'res', 'values', 'strings.xml'))) {
    throw new Error(`source has no res/values/strings.xml: ${sourceDir}`);
  }
  if (options.patches !== null) assertFile(options.patches, 'patches');
  if (options.configsDir !== null) assertDirectory(options.configsDir, 'configs-dir');
  const extraSmaliDirs = Array.isArray(options.extraSmali)
    ? options.extraSmali.filter(Boolean)
    : options.extraSmali !== null && options.extraSmali !== undefined
      ? [options.extraSmali]
      : [];
  for (const dir of extraSmaliDirs) assertDirectory(dir, 'extra-smali');
  if (options.bundleAiApk !== null) assertFile(options.bundleAiApk, 'bundle-ai-apk');
  if (options.mergeArscFrom !== null) assertFile(options.mergeArscFrom, 'merge-arsc-from');
  const patches = options.patches === null ? [] : loadPatches(options.patches);

  if (!options.dryRun) {
    fs.rmSync(stageDir, { recursive: true, force: true });
    fs.cpSync(sourceDir, stageDir, { recursive: true });
    for (const dir of extraSmaliDirs) {
      fs.cpSync(dir, path.join(stageDir, 'smali_classes2'), { recursive: true });
    }
  } else {
    fs.mkdirSync(stageDir, { recursive: true });
  }

  const readRoot = options.dryRun ? sourceDir : stageDir;
  stageCloneTexts(readRoot, stageDir, { allLocales: !options.dryRun });
  const patchResult = applyPatches({ patches, sourceDir, stageDir, dryRun: options.dryRun });
  const configs = copyConfigs(options.configsDir, stageDir);
  writeUtf8(path.join(stageDir, 'copied-configs.json'), `${JSON.stringify(configs, null, 2)}\n`);

  let aiModels = [];
  if (!options.dryRun && options.bundleAiApk !== null) {
    aiModels = extractAssetBins(options.bundleAiApk, path.join(stageDir, 'assets', 'ai_models'));
    ensureUncompressedAssets(stageDir, aiModels.map((rel) => `assets/ai_models/${rel}`));
  }
  let mergedArsc = { addedPackages: [], addedStrings: 0 };
  if (!options.dryRun) {
    mergedArsc = buildAndSign(stageDir, outApk, { mergeArscFrom: options.mergeArscFrom });
  }

  const summary = {
    dryRun: options.dryRun === true,
    stageDir,
    out: options.dryRun ? null : outApk,
    patchesApplied: patchResult.applied,
    patchesSkipped: patchResult.skipped,
    configs,
    aiModels,
    aiBundleSkipped: options.dryRun === true && options.bundleAiApk !== null,
    mergedArsc,
  };
  console.log(JSON.stringify(summary));
  return summary;
}

function applyPatches({ patches, sourceDir, stageDir, dryRun }) {
  const applied = [];
  const skipped = [];
  for (const patch of patches) {
    const staged = safeJoin(stageDir, patch.file);
    const source = safeJoin(dryRun ? sourceDir : stageDir, patch.file);
    const from = fs.existsSync(staged) ? staged : source;
    if (!fs.existsSync(from)) {
      if (patch.optional) {
        skipped.push(patch.id);
        continue;
      }
      throw new Error(`patch ${patch.id}: file not found: ${patch.file}`);
    }
    const rawText = readUtf8(from);
    const eol = rawText.includes('\r\n') ? '\r\n' : '\n';
    const normalized = rawText.replace(/\r\n/g, '\n');
    const findNorm = patch.find.replace(/\r\n/g, '\n');
    if (!normalized.includes(findNorm)) {
      if (patch.optional) {
        skipped.push(patch.id);
        continue;
      }
      throw new Error(`patch ${patch.id}: find text not present in ${patch.file}`);
    }
    const replaceNorm = patch.replace.replace(/\r\n/g, '\n');
    const updated = normalized.split(findNorm).join(replaceNorm).replace(/\n/g, eol);
    writeUtf8(safeJoin(stageDir, patch.file), updated);
    applied.push(patch.id);
  }
  return { applied, skipped };
}

function copyConfigs(configsDir, stageDir) {
  if (configsDir === null) return [];
  const copied = [];
  for (const full of walkFiles(configsDir)) {
    const relPosix = path.relative(configsDir, full).split(path.sep).join('/');
    if (relPosix.startsWith('../') || relPosix === '..' || path.isAbsolute(relPosix)) continue;
    if (isSkippedConfig(relPosix)) continue;
    const dest = safeJoin(path.join(stageDir, 'assets'), relPosix);
    fs.mkdirSync(path.dirname(dest), { recursive: true });
    fs.copyFileSync(full, dest);
    copied.push(`assets/${relPosix}`);
  }
  copied.sort((a, b) => a.localeCompare(b));
  return copied;
}

function buildAndSign(stageDir, outApk, { mergeArscFrom = null } = {}) {
  assertFile(JAVA, 'java');
  assertFile(APKTOOL, 'apktool');
  assertFile(SIGNER, 'signer');
  const outDir = path.dirname(outApk);
  fs.mkdirSync(outDir, { recursive: true });
  const unsignedPath = unsignedSibling(outApk);
  fs.rmSync(unsignedPath, { force: true });
  runJava(['-Xmx4g', '-jar', APKTOOL, 'b', stageDir, '-o', unsignedPath]);
  let mergedArsc = { addedPackages: [], addedStrings: 0 };
  if (mergeArscFrom !== null) {
    const modArsc = readZipEntryBytes(unsignedPath, 'resources.arsc');
    const stockArsc = readZipEntryBytes(mergeArscFrom, 'resources.arsc');
    const merged = mergeMissingArscPackages(modArsc, stockArsc);
    if (merged.addedPackages.length > 0) {
      replaceZipEntryStored(unsignedPath, 'resources.arsc', merged.arsc);
    }
    mergedArsc = { addedPackages: merged.addedPackages, addedStrings: merged.addedStrings };
  }
  runJava(['-jar', SIGNER, '--apks', unsignedPath, '--out', outDir]);
  publishSignedApk(outDir, unsignedPath, outApk);
  return mergedArsc;
}

function findSignedApk(outDir, unsignedPath) {
  const base = path.basename(unsignedPath, '.apk');
  const preferred = path.join(outDir, `${base}-aligned-debugSigned.apk`);
  if (fs.existsSync(preferred)) return preferred;
  if (!fs.existsSync(outDir)) return null;
  const matches = fs.readdirSync(outDir)
    .filter((name) => name.startsWith(base) && name.endsWith('-aligned-debugSigned.apk'));
  if (matches.length === 1) return path.join(outDir, matches[0]);
  return null;
}

function unsignedSibling(outApk) {
  const base = path.basename(outApk).replace(/\.apk$/i, '');
  return path.join(path.dirname(outApk), `${base}.unsigned.apk`);
}

function runJava(args) {
  const result = spawnSync(JAVA, args, { stdio: 'inherit', windowsHide: true });
  if (result.error) throw result.error;
  if (result.status !== 0) {
    throw new Error(`java exited ${result.status}: ${args.slice(0, 6).join(' ')}`);
  }
}

function removeControlCameraDeclaration(xml) {
  const selfClosing = /^[ \t]*<permission\b[^>]*android:name="com\.motorola\.camera\.permission\.CONTROL_CAMERA"[^>]*\/>[ \t]*\r?\n/gm;
  const paired = /^[ \t]*<permission\b[^>]*android:name="com\.motorola\.camera\.permission\.CONTROL_CAMERA"[^>]*>[\s\S]*?<\/permission>[ \t]*\r?\n/gm;
  return xml.replace(selfClosing, '').replace(paired, '').replace(
    /<permission\b[^>]*android:name="com\.motorola\.camera\.permission\.CONTROL_CAMERA"[^>]*\/>/g,
    '',
  );
}

function renameOwnedAuthorities(xml) {
  return xml.replace(/android:authorities="([^"]*)"/g, (full, value) => {
    const renamed = value.split(';').map((piece) => renameAuthorityPiece(piece)).join(';');
    return `android:authorities="${renamed}"`;
  });
}

function renameAuthorityPiece(piece) {
  const lead = piece.match(/^\s*/)[0];
  const auth = piece.trim();
  const trail = piece.slice(lead.length + auth.length);
  if (auth === EXTERNAL_AI_AUTHORITY || auth.startsWith(`${EXTERNAL_AI_AUTHORITY}/`)) return piece;
  if (auth === MOD_PACKAGE || auth.startsWith(`${MOD_PACKAGE}.`) || auth.startsWith(`${MOD_PACKAGE}/`)) return piece;
  if (auth === STOCK_PACKAGE) return `${lead}${MOD_PACKAGE}${trail}`;
  if (auth.startsWith(`${STOCK_PACKAGE}.`)) {
    return `${lead}${MOD_PACKAGE}.${auth.slice(STOCK_PACKAGE.length + 1)}${trail}`;
  }
  return piece;
}

function relaxMotoSignature(xml) {
  return xml.replace(/<uses-library\b[^>]*\/>/g, (tag) => {
    if (!tag.includes('android:name="com.motorola.motosignature"')) return tag;
    if (tag.includes('android:required="false"')) return tag;
    if (tag.includes('android:required="true"')) {
      return tag.replace('android:required="true"', 'android:required="false"');
    }
    return tag.replace(/\/>$/, ' android:required="false"/>');
  });
}

function assertManifestCloned(xml) {
  if (!xml.includes('package="com.motorola.camera3.mod"')) {
    throw new Error('manifest package was not cloned');
  }
  if (xml.includes('package="com.motorola.camera3"')) {
    throw new Error('stock manifest package remains');
  }
  if (/<permission\b[^>]*android:name="com\.motorola\.camera\.permission\.CONTROL_CAMERA"/.test(xml)) {
    throw new Error('CONTROL_CAMERA permission declaration remains');
  }
  if (xml.includes(`android:permission="${CONTROL_CAMERA}"`)) {
    throw new Error('CONTROL_CAMERA permission attribute remains');
  }
  const outsideQueries = xml.replace(/<queries\b[^>]*>[\s\S]*?<\/queries>/g, '');
  if (/android:authorities="com\.motorola\.camera3\.(?!mod)/.test(outsideQueries)) {
    throw new Error('stock provider authority remains outside queries');
  }
  const library = xml.match(/<uses-library\b[^>]*android:name="com\.motorola\.motosignature"[^>]*\/>/);
  if (library === null || !library[0].includes('android:required="false"')) {
    throw new Error('motosignature was not marked optional');
  }
}

function assertStringsCloned(rel, before, after) {
  if (/<string\b[^>]*\bname="act_name_camera"/.test(before)) {
    if (!/<string\b[^>]*\bname="act_name_camera"[^>]*>MotoCam Mod<\/string>/.test(after)) {
      throw new Error(`act_name_camera was not renamed in ${rel}`);
    }
  }
  if (/<string\b[^>]*\bname="provider_authority"/.test(before)) {
    if (after.includes(PROVIDER_AUTHORITY)) {
      throw new Error(`provider_authority still has the stock package in ${rel}`);
    }
    if (!after.includes(PROVIDER_AUTHORITY_MOD)) {
      throw new Error(`provider_authority was not cloned in ${rel}`);
    }
  }
}

function listLocaleStringRels(root) {
  const res = path.join(root, 'res');
  if (!fs.existsSync(res)) return [];
  const rels = [];
  for (const ent of fs.readdirSync(res, { withFileTypes: true })) {
    if (!ent.isDirectory()) continue;
    if (ent.name !== 'values' && !ent.name.startsWith('values-')) continue;
    const candidate = path.join(res, ent.name, 'strings.xml');
    if (fs.existsSync(candidate)) rels.push(`res/${ent.name}/strings.xml`);
  }
  rels.sort((a, b) => a.localeCompare(b));
  return rels;
}

function isAssetBin(name) {
  if (!name.startsWith('assets/') || name.endsWith('/')) return false;
  if (name.split('/').includes('..')) return false;
  return name.toLowerCase().endsWith('.bin');
}

export function ensureUncompressedAssets(stageDir, assetRels) {
  if (!assetRels || assetRels.length === 0) return;
  const ymlPath = path.join(stageDir, 'apktool.yml');
  if (!fs.existsSync(ymlPath)) return;
  const raw = readUtf8(ymlPath);
  const eol = raw.includes('\r\n') ? '\r\n' : '\n';
  const lines = raw.split(/\r?\n/);
  const existing = new Set(lines.map((l) => l.trim().replace(/^- /, '')));
  const toAdd = assetRels.filter((rel) => !existing.has(rel)).map((rel) => `- ${rel}`);
  if (toAdd.length === 0) return;
  const sectionIdx = lines.findIndex((l) => l.trim() === 'doNotCompress:');
  if (sectionIdx === -1) {
    lines.push('doNotCompress:', ...toAdd);
  } else {
    let insertAt = sectionIdx + 1;
    while (insertAt < lines.length && lines[insertAt].startsWith('- ')) insertAt += 1;
    lines.splice(insertAt, 0, ...toAdd);
  }
  writeUtf8(ymlPath, lines.join(eol));
}

function isSkippedConfig(relPosix) {
  const base = relPosix.split('/').pop().toLowerCase();
  if (base.endsWith('.md') || base.endsWith('.markdown')) return true;
  return base.includes('decrypted');
}

function readEocd(fd, size) {
  const tailSize = Math.min(size, 22 + 65535);
  const tail = Buffer.alloc(tailSize);
  const tailStart = size - tailSize;
  if (fs.readSync(fd, tail, 0, tailSize, tailStart) !== tailSize) throw new Error('truncated zip');
  for (let i = tail.length - 22; i >= 0; i -= 1) {
    if (tail.readUInt32LE(i) === EOCD_SIG) {
      return {
        entries: tail.readUInt16LE(i + 10),
        cdSize: tail.readUInt32LE(i + 12),
        cdOffset: tail.readUInt32LE(i + 16),
      };
    }
  }
  throw new Error('ZIP end of central directory not found');
}

function walkFiles(dir) {
  const out = [];
  for (const ent of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, ent.name);
    if (ent.isDirectory()) out.push(...walkFiles(full));
    else if (ent.isFile()) out.push(full);
  }
  return out;
}

function assertStageAllowed(sourceDir, stageDir) {
  if (samePath(sourceDir, stageDir)) throw new Error('stage-dir must differ from source');
  if (isInside(sourceDir, stageDir)) throw new Error('stage-dir must not be inside source');
  if (isInside(stageDir, sourceDir)) throw new Error('source must not be inside stage-dir');
  assertOutsideRepo(stageDir, '--stage-dir');
  const resolved = path.resolve(stageDir);
  if (resolved === path.parse(resolved).root) throw new Error('stage-dir must not be a drive root');
}

function assertOutsideRepo(target, label) {
  if (isInside(REPO_ROOT, target) || samePath(REPO_ROOT, target)) {
    throw new Error(`${label} must not be inside moto-camera-mod: ${target}`);
  }
}

function isInside(parent, child) {
  const rel = path.relative(path.resolve(parent), path.resolve(child));
  return rel !== '' && !rel.startsWith('..') && !path.isAbsolute(rel);
}

function samePath(left, right) {
  return path.resolve(left).toLowerCase() === path.resolve(right).toLowerCase();
}

function assertDirectory(dir, label) {
  if (!fs.existsSync(dir) || !fs.statSync(dir).isDirectory()) {
    throw new Error(`${label} is not a directory: ${dir}`);
  }
}

function assertFile(file, label) {
  if (!fs.existsSync(file) || !fs.statSync(file).isFile()) {
    throw new Error(`${label} is not a file: ${file}`);
  }
}

function normalizeRel(rel) {
  const posix = rel.replaceAll('\\', '/');
  if (posix.startsWith('/') || /^[A-Za-z]:/.test(posix)) throw new Error(`absolute patch path: ${rel}`);
  const parts = posix.split('/');
  if (parts.includes('..')) throw new Error(`patch path escapes the tree: ${rel}`);
  return parts.filter((part) => part.length > 0).join('/');
}

function safeJoin(root, relPosix) {
  const rel = normalizeRel(relPosix);
  const full = path.resolve(root, ...rel.split('/'));
  if (!isInside(root, full) && !samePath(root, full)) {
    throw new Error(`path escapes ${root}: ${relPosix}`);
  }
  return full;
}

function readUtf8(file) {
  return fs.readFileSync(file, 'utf8');
}

function writeUtf8(file, text) {
  fs.mkdirSync(path.dirname(file), { recursive: true });
  fs.writeFileSync(file, text);
}

function printHelp() {
  console.log(`Usage: node scripts/build_clone.mjs [options]

Clone MotCamera4 to ${MOD_PACKAGE} and, unless --dry-run, rebuild and sign it.

  --source <dir>         Decompiled tree (default: MotCamera4_v3)
  --stage-dir <dir>      Stage directory (default: moto-camera-re/work_clone)
  --out <apk>            Signed apk path (default: moto-camera-re/dist/MotCamera4-Mod.apk)
  --patches <json>       Array of {id, file, find, replace, optional?}
  --configs-dir <dir>    Copy non-markdown, non-decrypted files onto stage/assets
  --extra-smali <dir>    Copy additional smali tree into stage/smali_classes2 (repeatable)
  --bundle-ai-apk <apk>  Extract assets/*.bin into stage/assets/ai_models (full build)
  --merge-arsc-from <apk> Preserve extra resource packages (e.g. 0x81) from stock APK
  --dry-run              Stage manifest, default strings, patches, and the config list only
`);
}

function isDirectRun() {
  const entry = process.argv[1];
  if (!entry) return false;
  return path.resolve(entry).toLowerCase() === fileURLToPath(import.meta.url).toLowerCase();
}

if (isDirectRun()) {
  try {
    runPipeline(parseArgs(process.argv.slice(2)));
  } catch (error) {
    console.error(error instanceof Error ? error.message : String(error));
    process.exit(1);
  }
}
