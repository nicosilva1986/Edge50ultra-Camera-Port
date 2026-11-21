import { execFileSync } from 'node:child_process';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {
  REPO_ROOT,
  resolveBaseDir,
  resolveJava,
  resolveToolJar,
} from './env_paths.mjs';

const JAVA = resolveJava();
const JAVAC = path.join(path.dirname(JAVA), process.platform === 'win32' ? 'javac.exe' : 'javac');
const BASE = resolveBaseDir();
const R8_JAR = resolveToolJar(null, 'R8_JAR', 'r8.jar');
const APKTOOL = resolveToolJar(null, 'APKTOOL_JAR', 'apktool3.jar');

const STUBS_DIR = path.join(REPO_ROOT, 'patches', 'custom_imaging_java', 'stubs');
const SRC_DIR = path.join(REPO_ROOT, 'patches', 'custom_imaging_java', 'src');
const OUT_SMALI = path.join(REPO_ROOT, 'patches', 'custom_imaging_smali');

function collectFiles(dir, ext, acc = []) {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) collectFiles(full, ext, acc);
    else if (entry.name.endsWith(ext)) acc.push(full);
  }
  return acc;
}

if (!fs.existsSync(R8_JAR)) {
  throw new Error(`Missing r8.jar at ${R8_JAR}`);
}
if (!fs.existsSync(APKTOOL)) {
  throw new Error(`Missing apktool3.jar at ${APKTOOL}`);
}

const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'custom-imaging-build-'));
try {
  const classesStubDir = path.join(tmp, 'classes_stubs');
  const classesSrcDir = path.join(tmp, 'classes_src');
  const dexOutDir = path.join(tmp, 'dex_out');
  const apkOutDir = path.join(tmp, 'apk_decoded');
  fs.mkdirSync(classesStubDir, { recursive: true });
  fs.mkdirSync(classesSrcDir, { recursive: true });
  fs.mkdirSync(dexOutDir, { recursive: true });

  const stubFiles = collectFiles(STUBS_DIR, '.java');
  const srcFiles = collectFiles(SRC_DIR, '.java');
  console.log(`1. Compiling ${stubFiles.length} compile-time stubs + ${srcFiles.length} custom classes...`);
  execFileSync(
    JAVAC,
    ['--release', '11', '-d', classesStubDir, ...stubFiles],
    { stdio: 'inherit', windowsHide: true },
  );
  execFileSync(
    JAVAC,
    ['--release', '11', '-cp', classesStubDir, '-d', classesSrcDir, ...srcFiles],
    { stdio: 'inherit', windowsHide: true },
  );

  const classFiles = collectFiles(classesSrcDir, '.class');
  console.log(`2. Converting ${classFiles.length} class files to DEX via D8 (min-api 35)...`);
  execFileSync(
    JAVA,
    ['-cp', R8_JAR, 'com.android.tools.r8.D8', '--min-api', '35', '--output', dexOutDir, ...classFiles],
    { stdio: 'inherit', windowsHide: true },
  );

  // Pack classes.dex into minimal zip so apktool3 decodes cleanly to smali
  const dexZip = path.join(tmp, 'classes.apk');
  const jarExe = path.join(path.dirname(JAVA), process.platform === 'win32' ? 'jar.exe' : 'jar');
  execFileSync(
    jarExe,
    ['--create', '--file', dexZip, '-C', dexOutDir, 'classes.dex'],
    { stdio: 'inherit', windowsHide: true },
  );

  console.log('3. Disassembling classes.dex to Smali via apktool3...');
  execFileSync(
    JAVA,
    ['-jar', APKTOOL, 'd', '-f', '--no-res', dexZip, '-o', apkOutDir],
    { stdio: 'inherit', windowsHide: true },
  );

  const decodedCustom = path.join(apkOutDir, 'smali', 'com', 'motorola', 'camera', 'custom');
  if (!fs.existsSync(decodedCustom)) {
    throw new Error(`Missing decoded custom smali dir: ${decodedCustom}`);
  }

  fs.rmSync(OUT_SMALI, { recursive: true, force: true });
  const dstCustom = path.join(OUT_SMALI, 'com', 'motorola', 'camera', 'custom');
  fs.mkdirSync(dstCustom, { recursive: true });
  fs.cpSync(decodedCustom, dstCustom, { recursive: true });
  const smaliCount = collectFiles(dstCustom, '.smali').length;
  console.log(`DONE: wrote ${smaliCount} smali files to ${OUT_SMALI}`);
} finally {
  fs.rmSync(tmp, { recursive: true, force: true });
}
