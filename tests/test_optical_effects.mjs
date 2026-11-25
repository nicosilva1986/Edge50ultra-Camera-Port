import { spawnSync } from 'node:child_process';
import { mkdtempSync, mkdirSync, readFileSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';
import assert from 'node:assert/strict';
import { test } from 'node:test';
import { resolveJava } from '../scripts/env_paths.mjs';
import { stagePreviewEffects } from '../scripts/stage_preview_effects.mjs';

test('both preview shaders use quad coordinates and share the tiled LUT and optical uniforms', () => {
  const stage = mkdtempSync(join(tmpdir(), 'preview-fx-'));
  try {
    const raw = join(stage, 'res', 'raw');
    const drawables = join(stage, 'res', 'drawable');
    mkdirSync(raw, { recursive: true });
    mkdirSync(drawables);
    writeFileSync(join(drawables, 'ic_google_lens.xml'), '<old/>');
    for (const source of ['camera_preview', 'yuv_rgb']) {
      writeFileSync(join(raw, source + '_glvs.txt'), 'void main(){ gl_Position = a_Position; }');
    }
    writeFileSync(join(raw, 'camera_preview_glfs.txt'), '#extension GL_OES_EGL_image_external : require\n'
      + 'void main() { gl_FragColor = texture2D(u_Texture, v_TextureCoord) * u_Alpha; }');
    writeFileSync(join(raw, 'yuv_rgb_glfs.txt'), 'void main() { vec3 rgb = readYuv(v_textCoord); '
      + 'float r = rgb.r,g = rgb.g,b = rgb.b; gl_FragColor = vec4(r,g,b,1.0) * u_Opacity; }');
    const regional = join(stage, 'res', 'values-b+es+419');
    const frDir = join(stage, 'res', 'values-fr');
    mkdirSync(regional);
    mkdirSync(frDir);
    const strings = join(regional, 'strings.xml');
    writeFileSync(strings, '<resources><string name="main_setting_google_lens">Google Lens</string>'
      + '<string name="talkback_google_lens">Google Lens</string></resources>');
    writeFileSync(join(frDir, 'strings.xml'), '<resources><string name="main_setting_google_lens">Google Lens</string>'
      + '<string name="talkback_google_lens">Google Lens</string></resources>');
    stagePreviewEffects(stage);
    const replacements = readFileSync(strings, 'utf8').match(/>Efectos y filtros</g);
    assert.equal(replacements?.length, 2);
    assert.match(readFileSync(join(regional, 'port_effects.xml'), 'utf8'), /<string name="port_cat_film">Film<\/string>/);
    assert.match(readFileSync(join(regional, 'port_effects.xml'), 'utf8'), /<string name="port_cat_optical">Óptica<\/string>/);
    assert.match(readFileSync(join(regional, 'port_effects.xml'), 'utf8'), /<string name="port_pref_postproc_title">Perfil de posprocesado<\/string>/);
    assert.match(readFileSync(join(frDir, 'port_effects.xml'), 'utf8'), /<string name="port_hold_compare">Maintenir pour comparer<\/string>/);
    for (const badge of ['port_logo_leica.xml', 'port_logo_zeiss.xml', 'port_logo_google.xml', 'port_logo_fujifilm.xml', 'port_logo_kodak.xml', 'port_logo_ricoh.xml', 'port_logo_bokeh.xml']) {
      assert.match(readFileSync(join(drawables, badge), 'utf8'), /<vector /);
    }
    for (const name of ['camera_preview', 'yuv_rgb']) {
      const vertex = readFileSync(join(raw, name + '_glvs.txt'), 'utf8');
      const fragment = readFileSync(join(raw, name + '_glfs.txt'), 'utf8');
      assert.match(vertex, /v_LookQuad = a_Position\.xy/);
      assert.match(fragment, /length\(v_LookQuad \*/);
      for (const uniform of ['LutTex', 'Intensity', 'Vignette', 'Halation', 'Grain', 'Shoulder']) {
        assert.match(fragment, new RegExp('uniform (?:sampler2D|float) u_Effects' + uniform + '\\b'));
      }
      assert.match(fragment, /\/ 1089\.0/);
      assert.match(fragment, /if \(u_EffectsIntensity <= 0\.0\) return color/);
    }
    assert.match(readFileSync(join(drawables, 'ic_google_lens.xml'), 'utf8'), /<vector /);
    assert.throws(() => stagePreviewEffects(stage), /Unexpected preview shader structure/);
  } finally {
    rmSync(stage, { recursive: true, force: true });
  }
});

test('portrait apertures are distinct and gather preserves foreground and rejects opposite-depth samples', () => {
  const work = mkdtempSync(join(tmpdir(), 'bokeh-kernel-'));
  try {
    const source = fileURLToPath(new URL('../patches/custom_imaging_java/src/com/motorola/camera/custom/BokehKernel.java', import.meta.url));
    const probe = join(work, 'BokehProbe.java');
    writeFileSync(probe, `
package com.motorola.camera.custom;
import java.util.*;
class BokehProbe {
    public static void main(String[] args) {
        Set<String> signatures = new HashSet<>();
        for (int style = 1; style <= 5; style++) {
            float[] taps = BokehKernel.aperture(style);
            if (taps.length != 96) throw new AssertionError("tap count");
            signatures.add(Arrays.toString(taps));
            for (int i = 0; i < taps.length; i += 3) {
                if (Math.hypot(taps[i], taps[i+1]) > 1 || taps[i+2] <= 0) throw new AssertionError("tap bounds");
            }
        }
        if (signatures.size() != 5 || BokehKernel.coc(128,128) != 0
                || BokehKernel.coc(131,128) != 0 || !(BokehKernel.coc(140,128) > 0f)
                || BokehKernel.coc(202,128) != 1) throw new AssertionError("apertures or CoC");
        int size = 96;
        int[] image = new int[size*size];
        byte[] depth = new byte[image.length];
        for (int y = 0; y < size; y++) for (int x = 0; x < size; x++) {
            image[y*size+x] = x < 48 ? 0xffff0000 : 0xff0000ff;
            depth[y*size+x] = (byte)(x < 48 ? 32 : 200);
        }
        int[] output = BokehKernel.gather(image, depth, size, size, 32, 1);
        if (!Arrays.equals(image, output)) throw new AssertionError("depth bleed");
        int[] anamorphic = BokehKernel.gather(image, depth, size, size, 32, 4);
        for (int y = 0; y < size; y++) for (int x = 0; x < 48; x++) {
            if (anamorphic[y * size + x] != 0xffff0000) throw new AssertionError("anamorphic foreground bleed");
        }
        // Specular HDR linear-light bokeh must preserve >= 2.0x linear energy over naive gamma averaging.
        int[] specImg = new int[size * size];
        byte[] specDepth = new byte[size * size];
        Arrays.fill(specImg, 0xff101010);
        Arrays.fill(specDepth, (byte) 210);
        specImg[48 * size + 48] = 0xffffffff;
        specImg[48 * size + 49] = 0xffffffff;
        specImg[49 * size + 48] = 0xffffffff;
        specImg[49 * size + 49] = 0xffffffff;
        int[] specOut = BokehKernel.gather(specImg, specDepth, size, size, 32, 2);
        int centerVal = specOut[48 * size + 48] & 255;
        double linOut = Math.pow((centerVal + 0.055 * 255) / (1.055 * 255), 2.4);
        // Naive gamma average of 4/28 taps at 255 + 24/28 taps at 16 is ~50 sRGB (~0.032 linear).
        if (linOut < 0.085) throw new AssertionError("linear specular bokeh energy too dim: sRGB=" + centerVal + " lin=" + linOut);
    }
}
`);
    const java = resolveJava();
    const javac = join(dirname(java), process.platform === 'win32' ? 'javac.exe' : 'javac');
    const compile = spawnSync(javac, ['--release', '11', '-d', work, source, probe], { encoding: 'utf8' });
    assert.ifError(compile.error);
    assert.equal(compile.status, 0, compile.stderr);
    const run = spawnSync(java, ['-cp', work, 'com.motorola.camera.custom.BokehProbe'], { encoding: 'utf8' });
    assert.ifError(run.error);
    assert.equal(run.status, 0, run.stderr);
  } finally {
    rmSync(work, { recursive: true, force: true });
  }
});
