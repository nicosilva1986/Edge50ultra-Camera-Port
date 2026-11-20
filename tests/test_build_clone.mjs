import test from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import crypto from 'node:crypto';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import zlib from 'node:zlib';
import { fileURLToPath } from 'node:url';
import {
  ensureUncompressedAssets,
  extractAssetBins,
  parseArgs,
  publishSignedApk,
  stageCloneTexts,
  transformManifest,
  transformStrings,
} from '../scripts/build_clone.mjs';

import { resolveBaseDir } from '../scripts/env_paths.mjs';

const BASE_DIR = resolveBaseDir();
const SOURCE = path.join(BASE_DIR, 'decompiled', 'MotCamera4_v3');
const AI_APK = path.join(BASE_DIR, 'apks', 'MotCamera3AI.apk');
const HAS_SOURCE = fs.existsSync(SOURCE);
const HAS_AI_APK = fs.existsSync(AI_APK);
const SCRIPT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '../scripts/build_clone.mjs');
const MANIFEST = path.join(SOURCE, 'AndroidManifest.xml');
const STRINGS = path.join(SOURCE, 'res', 'values', 'strings.xml');
const SMALI = path.join(SOURCE, 'smali', 'androidx', 'databinding', 'DataBinderMapperImpl.smali');

function sha256(file) {
  return crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex');
}

function run(args) {
  return spawnSync(process.execPath, [SCRIPT, ...args], { encoding: 'utf8', windowsHide: true });
}

function writeZip(file, entries) {
  const locals = [];
  const centrals = [];
  let offset = 0;
  for (const entry of entries) {
    const name = Buffer.from(entry.name, 'utf8');
    const raw = Buffer.from(entry.data);
    const method = entry.method;
    const compressed = method === 8 ? zlib.deflateRawSync(raw) : raw;
    const crc = zlib.crc32(raw) >>> 0;
    const local = Buffer.alloc(30);
    local.writeUInt32LE(0x04034b50, 0);
    local.writeUInt16LE(20, 4);
    local.writeUInt16LE(method, 8);
    local.writeUInt32LE(crc, 14);
    local.writeUInt32LE(compressed.length, 18);
    local.writeUInt32LE(raw.length, 22);
    local.writeUInt16LE(name.length, 26);
    const blob = Buffer.concat([local, name, compressed]);
    const central = Buffer.alloc(46);
    central.writeUInt32LE(0x02014b50, 0);
    central.writeUInt16LE(20, 4);
    central.writeUInt16LE(20, 6);
    central.writeUInt16LE(method, 10);
    central.writeUInt32LE(crc, 16);
    central.writeUInt32LE(compressed.length, 20);
    central.writeUInt32LE(raw.length, 24);
    central.writeUInt16LE(name.length, 28);
    central.writeUInt32LE(offset, 42);
    locals.push(blob);
    centrals.push(Buffer.concat([central, name]));
    offset += blob.length;
  }
  const cd = Buffer.concat(centrals);
  const eocd = Buffer.alloc(22);
  eocd.writeUInt32LE(0x06054b50, 0);
  eocd.writeUInt16LE(entries.length, 8);
  eocd.writeUInt16LE(entries.length, 10);
  eocd.writeUInt32LE(cd.length, 12);
  eocd.writeUInt32LE(offset, 16);
  fs.writeFileSync(file, Buffer.concat([...locals, cd, eocd]));
}

test('dry-run clones the real manifest and strings without copying the tree or the source', { timeout: 30000, skip: !HAS_SOURCE }, () => {
  const before = {
    manifest: sha256(MANIFEST),
    strings: sha256(STRINGS),
    smali: sha256(SMALI),
  };
  const root = fs.mkdtempSync(path.join(os.tmpdir(), 'moto-clone-'));
  const stage = path.join(root, 'stage');
  const configs = path.join(root, 'configs');
  fs.mkdirSync(path.join(configs, 'nested'), { recursive: true });
  fs.writeFileSync(path.join(configs, 'iq_config_ctwo'), 'iq-body');
  fs.writeFileSync(path.join(configs, 'app_feature_ctwo'), 'feature-body');
  fs.writeFileSync(path.join(configs, 'mcf_config_ctwo'), 'mcf-body');
  fs.writeFileSync(path.join(configs, 'nested', 'iq_extra_ctwo'), 'extra-body');
  fs.writeFileSync(path.join(configs, 'README.md'), 'skip-md');
  fs.writeFileSync(path.join(configs, 'notes.markdown'), 'skip-markdown');
  fs.writeFileSync(path.join(configs, 'iq_config_ctwo.decrypted'), 'skip-decrypted');
  fs.writeFileSync(path.join(configs, 'nested', 'secret.decrypted.json'), 'skip-nested');
  const patches = path.join(root, 'patches.json');
  fs.writeFileSync(patches, JSON.stringify([
    {
      id: 'synthetic-authority-marker',
      file: 'smali/androidx/databinding/DataBinderMapperImpl.smali',
      find: 'const-string v1, "com.motorola.camera3.ctwo"',
      replace: 'const-string v1, "com.motorola.camera3.mod.ctwo"',
    },
    {
      id: 'optional-absent',
      file: 'smali/androidx/databinding/DataBinderMapperImpl.smali',
      find: '___patch_find_absent___',
      replace: 'OPTIONAL_SHOULD_NOT_APPLY',
      optional: true,
    },
  ]));
  try {
    const result = run([
      '--dry-run',
      '--source', SOURCE,
      '--stage-dir', stage,
      '--patches', patches,
      '--configs-dir', configs,
      '--bundle-ai-apk', AI_APK,
    ]);
    assert.equal(result.status, 0, result.stderr);
    assert.equal(sha256(MANIFEST), before.manifest);
    assert.equal(sha256(STRINGS), before.strings);
    assert.equal(sha256(SMALI), before.smali);
    assert.equal(fs.existsSync(path.join(stage, 'apktool.yml')), false);
    assert.equal(fs.existsSync(path.join(stage, 'res', 'values-el', 'strings.xml')), false);
    assert.equal(fs.existsSync(path.join(stage, 'assets', 'ai_models')), false);

    const manifest = fs.readFileSync(path.join(stage, 'AndroidManifest.xml'), 'utf8');
    assert.ok(manifest.includes('\r\n'));
    assert.ok(manifest.includes('package="com.motorola.camera3.mod"'));
    assert.equal(manifest.includes('package="com.motorola.camera3"'), false);
    assert.equal(manifest.includes('com.motorola.camera3.mod.mod'), false);
    assert.equal(
      manifest.split('com.motorola.camera3.mod.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION').length - 1,
      2,
    );
    assert.equal(manifest.includes('com.motorola.camera3.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION'), false);
    assert.equal(
      manifest.match(/<permission\b[^>]*android:name="com\.motorola\.camera\.permission\.CONTROL_CAMERA"/g),
      null,
    );
    assert.equal(
      manifest.match(/<uses-permission\b[^>]*android:name="com\.motorola\.camera\.permission\.CONTROL_CAMERA"/g).length,
      1,
    );
    assert.equal(manifest.includes('android:permission="com.motorola.camera.permission.CONTROL_CAMERA"'), false);
    assert.ok(manifest.includes('<uses-library android:name="com.motorola.motosignature" android:required="false"/>'));
    assert.ok(manifest.includes('<uses-feature android:name="com.motorola.camera3" android:required="true"/>'));
    assert.ok(manifest.includes('<uses-permission android:name="com.motorola.camera3.content.ai.ACCESS"/>'));
    assert.ok(manifest.includes('<package android:name="com.motorola.camera3.content.ai"/>'));
    assert.ok(manifest.includes('<data android:path="com.motorola.camera3" android:scheme="package"/>'));
    assert.ok(manifest.includes('android:authorities="@string/provider_authority"'));
    const queries = manifest.slice(manifest.indexOf('<queries>'), manifest.indexOf('</queries>'));
    assert.ok(queries.includes('android:authorities="com.motorola.camera3.content.ai"'));
    const outside = manifest.replace(/<queries\b[^>]*>[\s\S]*?<\/queries>/g, '');
    assert.equal(outside.includes('com.motorola.camera3.content.ai"'), false);
    const authorities = [...manifest.matchAll(/android:authorities="([^"]*)"/g)].map((match) => match[1]);
    const stock = authorities.filter((value) => value.split(';').some((part) => {
      const auth = part.trim();
      return auth.startsWith('com.motorola.camera3.') && !auth.startsWith('com.motorola.camera3.mod');
    }));
    assert.deepEqual(stock, ['com.motorola.camera3.content.ai']);
    for (const authority of [
      'com.motorola.camera3.mod.FileProvider',
      'com.motorola.camera3.mod.background.provider.filedatacontract.FileDataContentProvider',
      'com.motorola.camera3.mod.background.provider.filedatacontract.FileProviderCustom',
      'com.motorola.camera3.mod.background.provider.MemoryDataContentProvider',
      'com.motorola.camera3.mod.background.provider.SharedMemoryContentProvider',
    ]) {
      assert.ok(manifest.includes(`android:authorities="${authority}"`), authority);
    }

    const strings = fs.readFileSync(path.join(stage, 'res', 'values', 'strings.xml'), 'utf8');
    assert.ok(strings.includes('<string name="act_name_camera">MotoCam Mod</string>'));
    assert.equal(strings.includes('<string name="act_name_camera">Camera</string>'), false);
    assert.ok(strings.includes('<string name="act_name_camcorder">Camcorder</string>'));
    assert.ok(strings.includes('<string name="provider_authority">com.motorola.camera3.mod.provider.photos.specialtype</string>'));
    assert.equal(strings.includes('com.motorola.camera3.provider.photos.specialtype'), false);

    const smali = fs.readFileSync(path.join(stage, 'smali', 'androidx', 'databinding', 'DataBinderMapperImpl.smali'), 'utf8');
    assert.ok(smali.includes('const-string v1, "com.motorola.camera3.mod.ctwo"'));
    assert.equal(smali.includes('OPTIONAL_SHOULD_NOT_APPLY'), false);
    assert.equal(smali.includes('com.motorola.camera3.ctwo'), false);

    assert.equal(fs.readFileSync(path.join(stage, 'assets', 'iq_config_ctwo'), 'utf8'), 'iq-body');
    assert.equal(fs.readFileSync(path.join(stage, 'assets', 'app_feature_ctwo'), 'utf8'), 'feature-body');
    assert.equal(fs.readFileSync(path.join(stage, 'assets', 'mcf_config_ctwo'), 'utf8'), 'mcf-body');
    assert.equal(fs.readFileSync(path.join(stage, 'assets', 'nested', 'iq_extra_ctwo'), 'utf8'), 'extra-body');
    assert.equal(fs.existsSync(path.join(stage, 'assets', 'README.md')), false);
    assert.equal(fs.existsSync(path.join(stage, 'assets', 'notes.markdown')), false);
    assert.equal(fs.existsSync(path.join(stage, 'assets', 'iq_config_ctwo.decrypted')), false);
    assert.equal(fs.existsSync(path.join(stage, 'assets', 'nested', 'secret.decrypted.json')), false);
    assert.deepEqual(JSON.parse(fs.readFileSync(path.join(stage, 'copied-configs.json'), 'utf8')), [
      'assets/app_feature_ctwo',
      'assets/iq_config_ctwo',
      'assets/mcf_config_ctwo',
      'assets/nested/iq_extra_ctwo',
    ]);
    const summary = JSON.parse(result.stdout.trim().split(/\r?\n/).pop());
    assert.equal(summary.dryRun, true);
    assert.deepEqual(summary.patchesApplied, ['synthetic-authority-marker']);
    assert.deepEqual(summary.patchesSkipped, ['optional-absent']);
    assert.equal(summary.aiBundleSkipped, true);
  } finally {
    fs.rmSync(root, { recursive: true, force: true });
  }
});

test('a required patch miss fails and leaves the decompiled source unchanged', { skip: !HAS_SOURCE }, () => {
  const before = sha256(SMALI);
  const root = fs.mkdtempSync(path.join(os.tmpdir(), 'moto-clone-miss-'));
  const patches = path.join(root, 'patches.json');
  fs.writeFileSync(patches, JSON.stringify([
    {
      id: 'missing-required',
      file: 'smali/androidx/databinding/DataBinderMapperImpl.smali',
      find: 'this-string-is-not-in-the-file',
      replace: 'nope',
    },
  ]));
  try {
    const result = run([
      '--dry-run',
      '--source', SOURCE,
      '--stage-dir', path.join(root, 'stage'),
      '--patches', patches,
    ]);
    assert.notEqual(result.status, 0);
    assert.match(result.stderr, /missing-required/);
    assert.equal(sha256(SMALI), before);
  } finally {
    fs.rmSync(root, { recursive: true, force: true });
  }
});

test('an unknown flag fails before the stage directory is created', () => {
  const stage = path.join(os.tmpdir(), `moto-clone-unknown-${process.pid}-${Date.now()}`);
  const result = run(['--dry-run', '--source', SOURCE, '--stage-dir', stage, '--not-a-flag']);
  assert.notEqual(result.status, 0);
  assert.match(result.stderr, /unknown argument/);
  assert.equal(fs.existsSync(stage), false);
});

test('manifest cloning is idempotent and locale labels change without reformatting other strings', () => {
  if (HAS_SOURCE) {
    const original = fs.readFileSync(MANIFEST, 'utf8');
    const once = transformManifest(original);
    const twice = transformManifest(once);
    assert.equal(twice, once);
    assert.equal(once.includes('com.motorola.camera3.mod.mod'), false);
    assert.ok(once.includes('package="com.motorola.camera3.mod"'));
    assert.ok(once.includes('android:authorities="com.motorola.camera3.content.ai"'));
  }

  const untouched = '<?xml version="1.0" encoding="utf-8"?>\r\n<resources>\r\n    <string name="other">Keep</string>\r\n</resources>\r\n';
  assert.equal(transformStrings(untouched), untouched);
  const greek = '    <string name="act_name_camera">Κάμερα</string>\r\n    <string name="provider_authority">com.motorola.camera3.provider.photos.specialtype</string>\r\n';
  const renamed = transformStrings(greek);
  assert.equal(renamed, '    <string name="act_name_camera">MotoCam Mod</string>\r\n    <string name="provider_authority">com.motorola.camera3.mod.provider.photos.specialtype</string>\r\n');
  assert.equal(transformStrings(renamed), renamed);

  const root = fs.mkdtempSync(path.join(os.tmpdir(), 'moto-clone-locale-'));
  const source = path.join(root, 'source');
  const stage = path.join(root, 'stage');
  fs.mkdirSync(path.join(source, 'res', 'values'), { recursive: true });
  fs.mkdirSync(path.join(source, 'res', 'values-el'), { recursive: true });
  fs.mkdirSync(path.join(source, 'res', 'values-xx'), { recursive: true });
  fs.writeFileSync(path.join(source, 'AndroidManifest.xml'), [
    '<manifest package="com.motorola.camera3">',
    '    <uses-permission android:name="com.motorola.camera.permission.CONTROL_CAMERA"/>',
    '    <permission android:name="com.motorola.camera.permission.CONTROL_CAMERA" android:protectionLevel="signatureOrSystem"/>',
    '    <queries>',
    '        <provider android:authorities="com.motorola.camera3.content.ai"/>',
    '    </queries>',
    '    <permission android:name="com.motorola.camera3.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION" android:protectionLevel="signature"/>',
    '    <uses-permission android:name="com.motorola.camera3.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION"/>',
    '    <application>',
    '        <uses-library android:name="com.motorola.motosignature" android:required="true"/>',
    '        <provider android:authorities="com.motorola.camera3.FileProvider"/>',
    '    </application>',
    '</manifest>',
    '',
  ].join('\n'));
  const english = '<resources>\r\n    <string name="act_name_camera">Camera</string>\r\n    <string name="provider_authority">com.motorola.camera3.provider.photos.specialtype</string>\r\n</resources>\r\n';
  const hellenic = '<resources>\r\n    <string name="act_name_camera">Κάμερα</string>\r\n</resources>\r\n';
  const other = '<resources>\r\n    <string name="other">Keep</string>\r\n</resources>\r\n';
  fs.writeFileSync(path.join(source, 'res', 'values', 'strings.xml'), english);
  fs.writeFileSync(path.join(source, 'res', 'values-el', 'strings.xml'), hellenic);
  fs.writeFileSync(path.join(source, 'res', 'values-xx', 'strings.xml'), other);
  try {
    stageCloneTexts(source, stage, { allLocales: true });
    assert.equal(fs.readFileSync(path.join(source, 'res', 'values-el', 'strings.xml'), 'utf8'), hellenic);
    assert.ok(fs.readFileSync(path.join(stage, 'res', 'values-el', 'strings.xml'), 'utf8').includes('>MotoCam Mod</string>'));
    assert.equal(fs.readFileSync(path.join(stage, 'res', 'values-xx', 'strings.xml'), 'utf8'), other);
    assert.ok(fs.readFileSync(path.join(stage, 'res', 'values', 'strings.xml'), 'utf8').includes(PROVIDER_MOD));
    const stagedManifest = fs.readFileSync(path.join(stage, 'AndroidManifest.xml'), 'utf8');
    assert.ok(stagedManifest.includes('android:authorities="com.motorola.camera3.content.ai"'));
    assert.ok(stagedManifest.includes('android:authorities="com.motorola.camera3.mod.FileProvider"'));
    assert.equal(stagedManifest.includes('android:permission="com.motorola.camera.permission.CONTROL_CAMERA"'), false);
  } finally {
    fs.rmSync(root, { recursive: true, force: true });
  }
});

const PROVIDER_MOD = 'com.motorola.camera3.mod.provider.photos.specialtype';

test('bin extraction keeps stored and deflated assets/*.bin and drops everything else', () => {
  const root = fs.mkdtempSync(path.join(os.tmpdir(), 'moto-clone-zip-'));
  const apk = path.join(root, 'models.apk');
  const dest = path.join(root, 'ai_models');
  const stored = Buffer.from([1, 2, 3, 4, 5]);
  const deflated = Buffer.from('scene-model-bytes');
  writeZip(apk, [
    { name: 'assets/doc.bin', data: stored, method: 0 },
    { name: 'assets/nested/scene.bin', data: deflated, method: 8 },
    { name: 'assets/readme.md', data: Buffer.from('no'), method: 0 },
    { name: 'res/other.bin', data: Buffer.from('no'), method: 0 },
    { name: 'assets/../evil.bin', data: Buffer.from('no'), method: 0 },
  ]);
  try {
    const names = extractAssetBins(apk, dest);
    assert.deepEqual(names, ['doc.bin', 'nested/scene.bin']);
    assert.deepEqual(fs.readFileSync(path.join(dest, 'doc.bin')), stored);
    assert.equal(fs.readFileSync(path.join(dest, 'nested', 'scene.bin'), 'utf8'), 'scene-model-bytes');
    assert.equal(fs.existsSync(path.join(dest, 'readme.md')), false);
    assert.equal(fs.existsSync(path.join(dest, 'other.bin')), false);
    assert.equal(fs.existsSync(path.join(root, 'evil.bin')), false);
  } finally {
    fs.rmSync(root, { recursive: true, force: true });
  }
});

test('publish keeps the exact out path for aligned-debugSigned names and rejects unsigned fallback', () => {
  const root = fs.mkdtempSync(path.join(os.tmpdir(), 'moto-clone-sign-'));
  try {
    const unsignedOnlyDir = path.join(root, 'unsigned-only');
    fs.mkdirSync(unsignedOnlyDir);
    const unsigned = path.join(unsignedOnlyDir, 'MotCamera4-Mod.unsigned.apk');
    fs.writeFileSync(unsigned, 'unsigned-artifact');
    assert.throws(
      () => publishSignedApk(unsignedOnlyDir, unsigned, path.join(unsignedOnlyDir, 'MotCamera4-Mod.apk')),
      /signed apk not found/,
    );

    const namedDir = path.join(root, 'named');
    fs.mkdirSync(namedDir);
    const unsigned2 = path.join(namedDir, 'MotCamera4-Mod.unsigned.apk');
    const preferred = path.join(namedDir, 'MotCamera4-Mod.unsigned-aligned-debugSigned.apk');
    fs.writeFileSync(unsigned2, 'still-unsigned');
    fs.writeFileSync(preferred, 'aligned-debug-signed');
    fs.writeFileSync(path.join(namedDir, 'MotCamera4-Mod.unsigned-aligned.apk'), 'temp-aligned');
    const finalNamed = path.join(namedDir, 'MotCamera4-Mod.apk');
    publishSignedApk(namedDir, unsigned2, finalNamed);
    assert.equal(fs.readFileSync(finalNamed, 'utf8'), 'aligned-debug-signed');
    assert.deepEqual(fs.readdirSync(namedDir), ['MotCamera4-Mod.apk']);
  } finally {
    fs.rmSync(root, { recursive: true, force: true });
  }
});

test('parseArgs collects repeatable --extra-smali and ensureUncompressedAssets appends doNotCompress entries idempotently', () => {
  const parsed = parseArgs([
    '--extra-smali', 'dir-a',
    '--extra-smali=dir-b',
  ]);
  assert.deepEqual(parsed.extraSmali, ['dir-a', 'dir-b']);

  const root = fs.mkdtempSync(path.join(os.tmpdir(), 'moto-clone-yml-'));
  try {
    const ymlPath = path.join(root, 'apktool.yml');
    fs.writeFileSync(
      ymlPath,
      'version: 3.0.3\r\ndoNotCompress:\r\n- arsc\r\n- assets/ai_models/existing.bin\r\notherKey: true\r\n',
    );
    ensureUncompressedAssets(root, [
      'assets/ai_models/existing.bin',
      'assets/ai_models/doc_scan_model-1.2.bin',
    ]);
    const updated = fs.readFileSync(ymlPath, 'utf8');
    assert.equal(
      updated,
      'version: 3.0.3\r\ndoNotCompress:\r\n- arsc\r\n- assets/ai_models/existing.bin\r\n- assets/ai_models/doc_scan_model-1.2.bin\r\notherKey: true\r\n',
    );
    ensureUncompressedAssets(root, ['assets/ai_models/doc_scan_model-1.2.bin']);
    assert.equal(fs.readFileSync(ymlPath, 'utf8'), updated);
  } finally {
    fs.rmSync(root, { recursive: true, force: true });
  }
});
