import assert from 'node:assert/strict';
import test from 'node:test';
import { decryptMcf, encryptMcf, MCF4_KEY, MCF5_KEY } from '../scripts/mcf_crypto.mjs';

test('MCF4 key (PsDnGz8m) round-trips JSON payloads deterministically', () => {
  const sample = Buffer.from(JSON.stringify({ ctwo: { imagers: ['mot_ov50h'], flag: true } }), 'utf8');
  const encrypted = encryptMcf(sample, MCF4_KEY);
  assert.equal(encrypted.length % 8, 0);
  assert.deepEqual(decryptMcf(encrypted, MCF4_KEY), sample);
});

test('MCF5 key (uljw91D2) round-trips independently and differs from MCF4 ciphertext', () => {
  const sample = Buffer.from(JSON.stringify({ roadstr: { version: 5, luts: ['Tokyo Natural'] } }), 'utf8');
  const enc4 = encryptMcf(sample, MCF4_KEY);
  const enc5 = encryptMcf(sample, MCF5_KEY);
  assert.notDeepEqual(enc4, enc5);
  assert.deepEqual(decryptMcf(enc5, MCF5_KEY), sample);
  assert.throws(() => decryptMcf(enc5, MCF4_KEY), /Invalid Blowfish|incorrect header check|unknown compression/);
});

test('rejects empty or unaligned ciphertext and empty keys', () => {
  assert.throws(() => decryptMcf(Buffer.alloc(0)), /length/);
  assert.throws(() => decryptMcf(Buffer.from('1234567')), /length/);
  assert.throws(() => encryptMcf(Buffer.from('abc'), ''), /empty/);
});
