import { spawnSync } from 'node:child_process';
import { mkdtempSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';
import assert from 'node:assert/strict';
import { test } from 'node:test';
import { resolveJava } from '../scripts/env_paths.mjs';

test('EXIF graft preserves JPEG/R secondary image and MPF-relative offset in both byte orders', () => {
  const work = mkdtempSync(join(tmpdir(), 'gainmap-jpeg-'));
  try {
    const source = fileURLToPath(new URL('../patches/custom_imaging_java/src/com/motorola/camera/custom/GainmapJpeg.java', import.meta.url));
    const probe = join(work, 'GainmapProbe.java');
    writeFileSync(probe, `
package com.motorola.camera.custom;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.Arrays;
class GainmapProbe {
    public static void main(String[] args) throws Exception {
        byte[] metadata = {(byte)255,(byte)216,(byte)255,(byte)225,0,10,
                'E','x','i','f',0,0,12,34,(byte)255,(byte)217};
        for (ByteOrder order : new ByteOrder[] {ByteOrder.BIG_ENDIAN, ByteOrder.LITTLE_ENDIAN}) {
            byte[] nativeJpeg = new byte[74];
            ByteBuffer header = ByteBuffer.wrap(nativeJpeg);
            header.putShort((short)0xffd8).putShort((short)0xffe2).putShort((short)64);
            header.putInt(0x4d504600);
            header.order(order).putShort((short)(order == ByteOrder.BIG_ENDIAN ? 0x4d4d : 0x4949));
            header.putShort((short)42).putInt(8).putShort((short)1);
            header.putShort((short)0xb002).putShort((short)7).putInt(32).putInt(26);
            header.putInt(0);
            header.putInt(0).putInt(70).putInt(0).putInt(0);
            // TIFF begins at byte 10 and the secondary SOI is at byte 70.
            header.putInt(0).putInt(4).putInt(60).putInt(0);
            header.order(ByteOrder.BIG_ENDIAN).putShort((short)0xffd9);
            header.putShort((short)0xffd8).putShort((short)0xffd9);
            byte[] result = GainmapJpeg.withExif(nativeJpeg, metadata);
            if (result.length != 86 || !Arrays.equals(Arrays.copyOfRange(metadata, 2, 14),
                    Arrays.copyOfRange(result, 2, 14))) throw new AssertionError("EXIF graft");
            ByteBuffer mp = ByteBuffer.wrap(result).order(order);
            if (mp.getInt(52) != 82 || mp.getInt(72) != 60
                    || !Arrays.equals(Arrays.copyOfRange(result, 82, 86),
                    Arrays.copyOfRange(nativeJpeg, 70, 74))) throw new AssertionError("MPF pointers");
            expectInvalid(Arrays.copyOf(nativeJpeg, 73), metadata);
            header.order(order).putInt(60, 62);
            expectInvalid(nativeJpeg, metadata);
            header.putInt(60, 60);
            nativeJpeg[70] = 0;
            expectInvalid(nativeJpeg, metadata);
            nativeJpeg[70] = (byte)0xff;

            // Also support native JPEG/R that already carries an APP1 EXIF segment before MPF.
            byte[] withExistingExif = new byte[nativeJpeg.length + 10];
            System.arraycopy(nativeJpeg, 0, withExistingExif, 0, 2);
            ByteBuffer oldExif = ByteBuffer.wrap(withExistingExif);
            oldExif.putShort(2, (short)0xffe1).putShort(4, (short)8)
                    .putInt(6, 0x45786966).putShort(10, (short)0);
            System.arraycopy(nativeJpeg, 2, withExistingExif, 12, nativeJpeg.length - 2);
            ByteBuffer existingMp = ByteBuffer.wrap(withExistingExif).order(order);
            existingMp.putInt(50, 80); // primarySize moved +10 (40->50) and grew by 10 bytes
            byte[] replaced = GainmapJpeg.withExif(withExistingExif, metadata);
            if (replaced.length != result.length || !Arrays.equals(
                    Arrays.copyOfRange(metadata, 2, 14),
                    Arrays.copyOfRange(replaced, 2, 14))) {
                throw new AssertionError("replace existing EXIF");
            }
            ByteBuffer replacedMp = ByteBuffer.wrap(replaced).order(order);
            if (replacedMp.getInt(52) != 82 || replacedMp.getInt(72) != 60
                    || !Arrays.equals(Arrays.copyOfRange(replaced, 82, 86),
                    Arrays.copyOfRange(withExistingExif, 80, 84))) {
                throw new AssertionError("replaced EXIF MPF pointers");
            }
        }
    }

    private static void expectInvalid(byte[] jpeg, byte[] metadata) throws Exception {
        try {
            GainmapJpeg.withExif(jpeg, metadata);
            throw new AssertionError("accepted broken secondary JPEG boundary");
        } catch (IOException expected) {
        }
    }
}
`);
    const java = resolveJava();
    const javac = join(dirname(java), process.platform === 'win32' ? 'javac.exe' : 'javac');
    const compile = spawnSync(javac, ['--release', '11', '-d', work, source, probe], { encoding: 'utf8' });
    assert.ifError(compile.error);
    assert.equal(compile.status, 0, compile.stderr);
    const run = spawnSync(java, ['-cp', work, 'com.motorola.camera.custom.GainmapProbe'], { encoding: 'utf8' });
    assert.ifError(run.error);
    assert.equal(run.status, 0, run.stderr);
  } finally {
    rmSync(work, { recursive: true, force: true });
  }
});
