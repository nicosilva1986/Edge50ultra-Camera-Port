import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

export const REPO_ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');

export function resolveBaseDir() {
  return process.env.MOTO_CAMERA_RE_DIR
    ? path.resolve(process.env.MOTO_CAMERA_RE_DIR)
    : REPO_ROOT;
}

export function resolveJava(explicit) {
  if (explicit) return explicit;
  if (process.env.JAVA_HOME) {
    const ext = process.platform === 'win32' ? '.exe' : '';
    const candidate = path.join(process.env.JAVA_HOME, 'bin', `java${ext}`);
    if (fs.existsSync(candidate)) return candidate;
  }
  return 'java';
}

export function resolveJshell(explicit) {
  if (explicit) return explicit;
  if (process.env.JAVA_HOME) {
    const ext = process.platform === 'win32' ? '.exe' : '';
    const candidate = path.join(process.env.JAVA_HOME, 'bin', `jshell${ext}`);
    if (fs.existsSync(candidate)) return candidate;
  }
  return 'jshell';
}

export function resolveToolJar(explicit, envVar, defaultName) {
  if (explicit) return path.resolve(explicit);
  if (process.env[envVar]) return path.resolve(process.env[envVar]);
  const base = resolveBaseDir();
  for (const dir of [path.join(REPO_ROOT, 'tools'), path.join(base, 'tools')]) {
    const candidate = path.join(dir, defaultName);
    if (fs.existsSync(candidate)) return candidate;
  }
  return path.join(REPO_ROOT, 'tools', defaultName);
}

export function resolveConfigsDir(explicit) {
  if (explicit) return path.resolve(explicit);
  return path.join(resolveBaseDir(), 'configs');
}
