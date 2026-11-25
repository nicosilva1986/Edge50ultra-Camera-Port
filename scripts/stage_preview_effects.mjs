import fs from 'node:fs';
import path from 'node:path';

const effects = `
varying highp vec2 v_LookQuad;
uniform sampler2D u_EffectsLutTex;
uniform float u_EffectsIntensity;
uniform float u_EffectsVignette;
uniform float u_EffectsHalation;
uniform float u_EffectsGrain;
uniform float u_EffectsShoulder;

vec3 sampleCubeTexel(float r, float g, float b) {
    highp vec2 coord = vec2((r + 0.5) / 33.0, (b * 33.0 + g + 0.5) / 1089.0);
    return texture2D(u_EffectsLutTex, coord).rgb;
}

vec3 readLook(vec3 color) {
    highp vec3 cell = clamp(color, 0.0, 1.0) * 32.0;
    highp vec3 base = min(floor(cell), vec3(31.0));
    highp vec3 f = cell - base;
    highp float x = f.r;
    highp float y = f.g;
    highp float z = f.b;
    highp vec3 sx = vec3(1.0, 0.0, 0.0);
    highp vec3 sy = vec3(0.0, 1.0, 0.0);
    highp vec3 sz = vec3(0.0, 0.0, 1.0);
    if (x < y) {
        highp float t = x; x = y; y = t;
        highp vec3 st = sx; sx = sy; sy = st;
    }
    if (y < z) {
        highp float t = y; y = z; z = t;
        highp vec3 st = sy; sy = sz; sz = st;
    }
    if (x < y) {
        highp float t = x; x = y; y = t;
        highp vec3 st = sx; sx = sy; sy = st;
    }
    vec3 c0 = sampleCubeTexel(base.r, base.g, base.b);
    vec3 p1 = base + sx;
    vec3 c1 = sampleCubeTexel(p1.r, p1.g, p1.b);
    vec3 p2 = p1 + sy;
    vec3 c2 = sampleCubeTexel(p2.r, p2.g, p2.b);
    vec3 p3 = p2 + sz;
    vec3 c3 = sampleCubeTexel(p3.r, p3.g, p3.b);
    return c0 * (1.0 - x) + c1 * (x - y) + c2 * (y - z) + c3 * z;
}

float highlight(vec3 rgb) {
    vec3 lin = pow(max(rgb, vec3(0.0)), vec3(2.2));
    float value = u_EffectsHalation < 0.0 ? max(lin.r, 0.70 * dot(lin, vec3(0.2126, 0.7152, 0.0722)))
        : dot(lin, vec3(0.2126, 0.7152, 0.0722));
    float ex = smoothstep(0.56, 1.0, value);
    return ex * (1.0 + 0.65 * ex);
}

vec3 applyPreviewLook(vec3 color, vec2 uv) {
    if (u_EffectsIntensity <= 0.0) return color;
    vec3 graded = readLook(color);
    float y = dot(graded, vec3(0.2126, 0.7152, 0.0722));
    float corners = smoothstep(0.38, 1.35, length(v_LookQuad * vec2(0.9, 1.0)));
    graded *= 1.0 - u_EffectsVignette * corners * (1.0 - smoothstep(0.45, 1.0, y));
    if (u_EffectsHalation != 0.0) {
        vec2 d1 = vec2(0.0036, 0.0);
        vec2 d2 = vec2(0.0082, 0.0082);
        float core = 0.20 * (highlight(color)
            + highlight(sampleLookSource(uv + d1.xy)) + highlight(sampleLookSource(uv - d1.xy))
            + highlight(sampleLookSource(uv + d1.yx)) + highlight(sampleLookSource(uv - d1.yx)));
        float veil = 0.25 * (highlight(sampleLookSource(uv + d2))
            + highlight(sampleLookSource(uv - d2))
            + highlight(sampleLookSource(uv + vec2(d2.x, -d2.y)))
            + highlight(sampleLookSource(uv + vec2(-d2.x, d2.y))));
        float glow = 0.62 * core + 0.38 * veil;
        vec3 tint = u_EffectsHalation < 0.0 ? vec3(1.0, 0.18, 0.04) : vec3(1.0, 0.98, 0.95);
        graded += abs(u_EffectsHalation) * tint * glow * (1.0 - 0.55 * graded);
    }
    if (u_EffectsGrain > 0.0) {
        highp float noise = fract(sin(dot(gl_FragCoord.xy, vec2(12.9898, 78.233))) * 43758.5453);
        graded += (noise - 0.5) * u_EffectsGrain * (1.0 - y);
    }
    if (u_EffectsShoulder > 0.0) {
        float peak = max(graded.r, max(graded.g, graded.b));
        float knee = 224.0 / 255.0;
        if (peak > knee) {
            float excess = peak - knee;
            float span = 128.0 / 255.0;
            float targetPeak = knee + span * excess / (span + excess);
            graded *= mix(1.0, targetPeak / peak, u_EffectsShoulder);
        }
    }
    return mix(color, clamp(graded, 0.0, 1.0), u_EffectsIntensity);
}
`;

// 24dp clean-room viewfinder trigger icon matching Moto ControlBar white monochrome line weight.
const icon = `<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24">
    <path android:fillColor="#FFFFFF"
        android:pathData="M10,2L12.25,7.75L18,10L12.25,12.25L10,18L7.75,12.25L2,10L7.75,7.75Z M19,13L20.4,16.6L24,18L20.4,19.4L19,23L17.6,19.4L14,18L17.6,16.6Z"/>
</vector>
`;

// Faithful crisp 32x32 monochrome/brand SVG VectorDrawables for Effects preset cards.
export const BRAND_BADGES = {
  port_logo_none: `<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="28dp" android:height="28dp" android:viewportWidth="32" android:viewportHeight="32">
    <path android:fillColor="#00000000" android:strokeColor="#CBD5E1" android:strokeWidth="2.2"
        android:pathData="M16,4.5A11.5,11.5 0 1,1 4.5,16A11.5,11.5 0 0,1 16,4.5Z"/>
    <path android:fillColor="#00000000" android:strokeColor="#CBD5E1" android:strokeWidth="2.2" android:strokeLineCap="round"
        android:pathData="M8.5,23.5L23.5,8.5"/>
</vector>
`,
  port_logo_leica: `<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="28dp" android:height="28dp" android:viewportWidth="32" android:viewportHeight="32">
    <path android:fillColor="#E2001A" android:pathData="M16,2A14,14 0 1,1 2,16A14,14 0 0,1 16,2Z"/>
    <path android:fillColor="#00000000" android:strokeColor="#FFFFFF" android:strokeWidth="1.55"
        android:strokeLineCap="round" android:strokeLineJoin="round"
        android:pathData="M8.8,11.0C7.8,14.8 7.0,17.8 6.4,19.4C7.9,19.4 9.7,19.2 11.4,18.7"/>
    <path android:fillColor="#00000000" android:strokeColor="#FFFFFF" android:strokeWidth="1.35"
        android:strokeLineCap="round" android:strokeLineJoin="round"
        android:pathData="M12.2,17.0C13.6,17.0 14.7,16.1 14.5,15.3C14.3,14.5 13.0,14.5 12.2,15.6C11.4,16.7 11.7,18.7 13.3,18.9C14.4,19.0 15.3,18.2 16.0,17.1L16.7,15.0"/>
    <path android:fillColor="#00000000" android:strokeColor="#FFFFFF" android:strokeWidth="1.35"
        android:strokeLineCap="round" android:strokeLineJoin="round"
        android:pathData="M16.1,16.8C15.9,18.2 16.5,19.0 17.6,18.8C18.3,18.6 18.8,18.0 19.2,17.3"/>
    <path android:fillColor="#00000000" android:strokeColor="#FFFFFF" android:strokeWidth="1.35"
        android:strokeLineCap="round" android:strokeLineJoin="round"
        android:pathData="M21.8,15.2C20.6,14.4 19.1,15.2 18.8,16.8C18.5,18.3 19.6,19.1 21.0,18.6"/>
    <path android:fillColor="#00000000" android:strokeColor="#FFFFFF" android:strokeWidth="1.35"
        android:strokeLineCap="round" android:strokeLineJoin="round"
        android:pathData="M24.8,15.3C23.5,14.6 22.0,15.5 21.8,17.0C21.6,18.4 22.7,19.1 24.0,18.1L25.0,15.2L24.5,18.6C24.5,19.0 25.1,19.0 25.7,18.2"/>
    <path android:fillColor="#FFFFFF" android:pathData="M17.2,12.2A0.95,0.95 0 1,1 15.3,12.2A0.95,0.95 0 0,1 17.2,12.2Z"/>
</vector>
`,
  port_logo_zeiss: `<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="28dp" android:height="28dp" android:viewportWidth="32" android:viewportHeight="32">
    <path android:fillColor="#0F55B4"
        android:pathData="M3.5,4.5H28.5V16.0C28.5,23.2 22.8,28.5 16,28.5C9.2,28.5 3.5,23.2 3.5,16.0Z"/>
    <path android:fillColor="#00000000" android:strokeColor="#D8ECFF" android:strokeWidth="0.9"
        android:pathData="M4.6,5.6H27.4V16.0C27.4,22.4 22.2,27.3 16,27.3C9.8,27.3 4.6,22.4 4.6,16.0Z"/>
    <path android:fillColor="#FFFFFF"
        android:pathData="M6.2,11.0H10.8V12.3L7.8,16.4H10.9V17.7H6.0V16.4L9.0,12.3H6.2Z"/>
    <path android:fillColor="#FFFFFF"
        android:pathData="M11.6,11.0H15.6V12.3H13.0V13.7H15.2V15.0H13.0V16.4H15.7V17.7H11.6Z"/>
    <path android:fillColor="#FFFFFF"
        android:pathData="M16.5,11.0H18.0V17.7H16.5Z"/>
    <path android:fillColor="#FFFFFF"
        android:pathData="M18.9,12.8C18.9,11.6 19.9,10.9 21.1,10.9C22.1,10.9 22.8,11.3 23.0,12.1L21.7,12.5C21.6,12.1 21.4,12.0 21.0,12.0C20.5,12.0 20.3,12.3 20.3,12.7C20.3,13.6 23.1,13.6 23.1,15.8C23.1,17.0 22.1,17.8 20.8,17.8C19.6,17.8 18.8,17.2 18.6,16.2L19.9,15.8C20.1,16.4 20.4,16.6 20.9,16.6C21.4,16.6 21.7,16.3 21.7,15.9C21.7,14.8 18.9,14.9 18.9,12.8Z"/>
    <path android:fillColor="#FFFFFF"
        android:pathData="M23.7,12.8C23.7,11.6 24.6,10.9 25.8,10.9C26.8,10.9 27.5,11.3 27.7,12.1L26.4,12.5C26.3,12.1 26.1,12.0 25.7,12.0C25.2,12.0 25.0,12.3 25.0,12.7C25.0,13.6 27.8,13.6 27.8,15.8C27.8,17.0 26.8,17.8 25.5,17.8C24.3,17.8 23.5,17.2 23.3,16.2L24.6,15.8C24.8,16.4 25.1,16.6 25.6,16.6C26.1,16.6 26.4,16.3 26.4,15.9C26.4,14.8 23.7,14.9 23.7,12.8Z"/>
</vector>
`,
  port_logo_google: `<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="28dp" android:height="28dp" android:viewportWidth="32" android:viewportHeight="32">
    <path android:fillColor="#FFFFFF" android:pathData="M16,2.5A13.5,13.5 0 1,1 2.5,16A13.5,13.5 0 0,1 16,2.5Z"/>
    <path android:fillColor="#4285F4"
        android:pathData="M25.6,16.2C25.6,15.4 25.5,14.8 25.4,14.2H16V18.0H21.5C21.2,19.4 20.5,20.5 19.3,21.3V23.8H22.6C24.5,22.0 25.6,19.4 25.6,16.2Z"/>
    <path android:fillColor="#34A853"
        android:pathData="M16,26.0C18.7,26.0 21.0,25.1 22.6,23.8L19.3,21.3C18.4,21.9 17.3,22.3 16,22.3C13.4,22.3 11.2,20.5 10.4,18.1H7.0V20.7C8.7,24.0 12.1,26.0 16,26.0Z"/>
    <path android:fillColor="#FBBC05"
        android:pathData="M10.4,18.1C10.2,17.4 10.1,16.7 10.1,16.0C10.1,15.3 10.2,14.6 10.4,13.9V11.3H7.0C6.3,12.7 5.9,14.3 5.9,16.0C5.9,17.7 6.3,19.3 7.0,20.7Z"/>
    <path android:fillColor="#EA4335"
        android:pathData="M16,9.7C17.5,9.7 18.8,10.2 19.8,11.2L22.7,8.3C21.0,6.7 18.7,5.8 16,5.8C12.1,5.8 8.7,8.0 7.0,11.3L10.4,13.9C11.2,11.5 13.4,9.7 16,9.7Z"/>
</vector>
`,
  port_logo_promist: `<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="28dp" android:height="28dp" android:viewportWidth="32" android:viewportHeight="32">
    <path android:fillColor="#202530" android:strokeColor="#A8B4C6" android:strokeWidth="2.0"
        android:pathData="M16,3A13,13 0 1,1 3,16A13,13 0 0,1 16,3Z"/>
    <path android:fillColor="#28FFF2DE" android:strokeColor="#FFF2DE" android:strokeWidth="1.0"
        android:pathData="M16,7A9,9 0 1,1 7,16A9,9 0 0,1 16,7Z"/>
    <path android:fillColor="#FFF8EB"
        android:pathData="M16,9.5L17.4,14.6L22.5,16L17.4,17.4L16,22.5L14.6,17.4L9.5,16L14.6,14.6Z"/>
</vector>
`,
  port_logo_cinestill: `<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="28dp" android:height="28dp" android:viewportWidth="32" android:viewportHeight="32">
    <path android:fillColor="#181A20" android:strokeColor="#FF521B" android:strokeWidth="1.6"
        android:pathData="M5,4H27C28.1,4 29,4.9 29,6V26C29,27.1 28.1,28 27,28H5C3.9,28 3,27.1 3,26V6C3,4.9 3.9,4 5,4Z"/>
    <path android:fillColor="#FF7043"
        android:pathData="M5.5,6.5H8V8.8H5.5Z M24,6.5H26.5V8.8H24Z M5.5,23.2H8V25.5H5.5Z M24,23.2H26.5V25.5H24Z"/>
    <path android:fillColor="#FFFFFF"
        android:pathData="M15.2,12.2C14.3,11.4 13.0,11.2 11.8,11.6C10.2,12.1 9.2,13.8 9.2,16.0C9.2,18.2 10.2,19.9 11.8,20.4C13.0,20.8 14.3,20.5 15.2,19.6L13.8,18.2C13.3,18.7 12.7,18.9 12.1,18.7C11.3,18.4 11.0,17.4 11.0,16.0C11.0,14.6 11.3,13.6 12.1,13.3C12.7,13.1 13.3,13.3 13.8,13.8Z"/>
    <path android:fillColor="#FF5722"
        android:pathData="M16.5,13.2C16.5,11.9 17.6,11.1 19.3,11.1C20.5,11.1 21.5,11.6 21.8,12.7L20.1,13.2C19.9,12.7 19.6,12.6 19.1,12.6C18.5,12.6 18.2,12.8 18.2,13.2C18.2,14.5 22.1,14.4 22.1,17.6C22.1,19.3 20.8,20.5 19.0,20.5C17.4,20.5 16.3,19.6 16.0,18.3L17.8,17.8C18.0,18.6 18.4,18.9 19.1,18.9C19.8,18.9 20.3,18.5 20.3,17.8C20.3,16.1 16.5,16.2 16.5,13.2Z"/>
</vector>
`,
  port_logo_fujifilm: `<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="28dp" android:height="28dp" android:viewportWidth="32" android:viewportHeight="32">
    <path android:fillColor="#009060"
        android:pathData="M5,4H27C28.7,4 30,5.3 30,7V25C30,26.7 28.7,28 27,28H5C3.3,28 2,26.7 2,25V7C2,5.3 3.3,4 5,4Z"/>
    <path android:fillColor="#FFFFFF"
        android:pathData="M5.2,11.6H10.5V13.4H7.2V15.3H10.0V17.1H7.2V20.6H5.2Z"/>
    <path android:fillColor="#FFFFFF"
        android:pathData="M11.6,11.6H13.6V17.4C13.6,18.4 14.1,18.9 14.9,18.9C15.7,18.9 16.2,18.4 16.2,17.4V11.6H18.2V17.5C18.2,19.6 16.9,20.8 14.9,20.8C12.9,20.8 11.6,19.6 11.6,17.5Z"/>
    <path android:fillColor="#FFFFFF"
        android:pathData="M21.8,11.6H23.8V17.5C23.8,19.6 22.4,20.8 20.6,20.8C19.8,20.8 19.2,20.5 18.8,20.2L19.6,18.5C19.9,18.7 20.2,18.9 20.6,18.9C21.4,18.9 21.8,18.4 21.8,17.5Z"/>
    <path android:fillColor="#FFFFFF"
        android:pathData="M25.0,11.6H27.0V20.6H25.0Z"/>
</vector>
`,
  port_logo_kodak: `<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="28dp" android:height="28dp" android:viewportWidth="32" android:viewportHeight="32">
    <path android:fillColor="#FFB800"
        android:pathData="M5.5,4H26.5C27.9,4 29,5.1 29,6.5V25.5C29,26.9 27.9,28 26.5,28H5.5C4.1,28 3,26.9 3,25.5V6.5C3,5.1 4.1,4 5.5,4Z"/>
    <path android:fillColor="#E30613"
        android:pathData="M9.0,6.8H13.5V14.4L20.5,6.8H25.0L16.2,16.0L25.0,25.2H20.2L13.5,17.8V25.2H9.0Z"/>
</vector>
`,
  port_logo_ricoh: `<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="28dp" android:height="28dp" android:viewportWidth="32" android:viewportHeight="32">
    <path android:fillColor="#161920" android:strokeColor="#64748B" android:strokeWidth="1.2"
        android:pathData="M5,4H27C28.1,4 29,4.9 29,6V26C29,27.1 28.1,28 27,28H5C3.9,28 3,27.1 3,26V6C3,4.9 3.9,4 5,4Z"/>
    <path android:fillColor="#F8FAFC"
        android:pathData="M6.8,11.0H14.8V13.4H9.4V18.6H12.5V16.8H10.8V14.8H14.8V21.0H6.8Z"/>
    <path android:fillColor="#F8FAFC"
        android:pathData="M16.8,11.0H23.2C24.5,11.0 25.4,11.9 25.4,13.2V15.3C25.4,16.3 24.8,17.1 23.9,17.4L25.5,21.0H22.7L21.3,17.6H19.4V21.0H16.8ZM19.4,13.1V15.5H22.6V13.1Z"/>
    <path android:fillColor="#E53935" android:pathData="M26.2,7.2A1.6,1.6 0 1,1 23.0,7.2A1.6,1.6 0 0,1 26.2,7.2Z"/>
</vector>
`,
  port_logo_ccd: `<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="28dp" android:height="28dp" android:viewportWidth="32" android:viewportHeight="32">
    <path android:fillColor="#263238" android:strokeColor="#90A4AE" android:strokeWidth="1.4"
        android:pathData="M5,6H27C28.7,6 30,7.3 30,9V23C30,24.7 28.7,26 27,26H5C3.3,26 2,24.7 2,23V9C2,7.3 3.3,6 5,6Z"/>
    <path android:fillColor="#00E5FF"
        android:pathData="M13.5,16.0A4.8,4.8 0 1,1 3.9,16.0A4.8,4.8 0 0,1 13.5,16.0Z"/>
    <path android:fillColor="#102027"
        android:pathData="M11.3,16.0A2.6,2.6 0 1,1 6.1,16.0A2.6,2.6 0 0,1 11.3,16.0Z"/>
    <path android:fillColor="#ECEFF1"
        android:pathData="M16.5,12.5H26.5V19.5H16.5Z"/>
    <path android:fillColor="#263238"
        android:pathData="M18.0,14.5H25.0V17.5H18.0Z"/>
    <path android:fillColor="#FFD54F" android:pathData="M26.8,9.0A1.2,1.2 0 1,1 24.4,9.0A1.2,1.2 0 0,1 26.8,9.0Z"/>
</vector>
`,
  port_logo_bokeh: `<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="28dp" android:height="28dp" android:viewportWidth="32" android:viewportHeight="32">
    <path android:fillColor="#1B2330" android:pathData="M16,2.5A13.5,13.5 0 1,1 2.5,16A13.5,13.5 0 0,1 16,2.5Z"/>
    <path android:fillColor="#558BEAFF" android:strokeColor="#8BEAFF" android:strokeWidth="1.6"
        android:pathData="M14.5,7.5A8.0,8.0 0 1,1 6.5,15.5A8.0,8.0 0 0,1 14.5,7.5Z"/>
    <path android:fillColor="#44FFFFFF" android:pathData="M21.0,14.5A5.0,5.0 0 1,1 11.0,14.5A5.0,5.0 0 0,1 21.0,14.5Z"/>
</vector>
`,
  port_logo_bokeh_biotar: `<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="28dp" android:height="28dp" android:viewportWidth="32" android:viewportHeight="32">
    <path android:fillColor="#0F55B4" android:pathData="M16,2.5A13.5,13.5 0 1,1 2.5,16A13.5,13.5 0 0,1 16,2.5Z"/>
    <path android:fillColor="#33FFFFFF" android:strokeColor="#FFFFFF" android:strokeWidth="1.6"
        android:pathData="M9.0,12.2A8.4,4.6 35 1,1 23.0,19.8A8.4,4.6 35 1,1 9.0,12.2Z"/>
    <path android:fillColor="#8BEAFF" android:pathData="M18.0,16A2.0,2.0 0 1,1 14.0,16A2.0,2.0 0 0,1 18.0,16Z"/>
</vector>
`,
  port_logo_bokeh_planar: `<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="28dp" android:height="28dp" android:viewportWidth="32" android:viewportHeight="32">
    <path android:fillColor="#0F55B4" android:pathData="M16,2.5A13.5,13.5 0 1,1 2.5,16A13.5,13.5 0 0,1 16,2.5Z"/>
    <path android:fillColor="#44FFFFFF" android:strokeColor="#FFFFFF" android:strokeWidth="1.7"
        android:pathData="M16,7.5L22.2,10.6L23.8,17.4L19.6,23.2H12.4L8.2,17.4L9.8,10.6Z"/>
</vector>
`,
  port_logo_bokeh_sonnar: `<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="28dp" android:height="28dp" android:viewportWidth="32" android:viewportHeight="32">
    <path android:fillColor="#0F55B4" android:pathData="M16,2.5A13.5,13.5 0 1,1 2.5,16A13.5,13.5 0 0,1 16,2.5Z"/>
    <path android:fillColor="#38FFFFFF" android:pathData="M16,7.5A8.5,8.5 0 1,1 7.5,16A8.5,8.5 0 0,1 16,7.5Z"/>
    <path android:fillColor="#B8FFFFFF" android:pathData="M16,11.5A4.5,4.5 0 1,1 11.5,16A4.5,4.5 0 0,1 16,11.5Z"/>
</vector>
`,
  port_logo_bokeh_anamorphic: `<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="28dp" android:height="28dp" android:viewportWidth="32" android:viewportHeight="32">
    <path android:fillColor="#0F55B4" android:pathData="M16,2.5A13.5,13.5 0 1,1 2.5,16A13.5,13.5 0 0,1 16,2.5Z"/>
    <path android:fillColor="#44FFFFFF" android:strokeColor="#FFFFFF" android:strokeWidth="1.6"
        android:pathData="M16,7.8C19.0,7.8 21.0,11.5 21.0,16C21.0,20.5 19.0,24.2 16,24.2C13.0,24.2 11.0,20.5 11.0,16C11.0,11.5 13.0,7.8 16,7.8Z"/>
    <path android:fillColor="#8BEAFF" android:pathData="M5.5,15.1H26.5V16.9H5.5Z"/>
</vector>
`,
  port_logo_bokeh_bspeed: `<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="28dp" android:height="28dp" android:viewportWidth="32" android:viewportHeight="32">
    <path android:fillColor="#1B2330" android:pathData="M16,2.5A13.5,13.5 0 1,1 2.5,16A13.5,13.5 0 0,1 16,2.5Z"/>
    <path android:fillColor="#448BEAFF" android:strokeColor="#8BEAFF" android:strokeWidth="1.8" android:strokeLineJoin="round"
        android:pathData="M16,8.0L23.5,21.5H8.5Z"/>
</vector>
`,
};

const EN_STRINGS = {
  effectsLabel: 'Effects and filters',
  prefPostprocTitle: 'Post-processing profile',
  catAll: 'All',
  catOptical: 'Optical',
  catHdr: 'HDR+',
  catFilm: 'Film',
  catBokeh: 'Bokeh Lens',
  lookNone: 'Original',
  bokehStock: 'Stock',
  intensityFmt: 'Intensity %1$d%%',
  intensityCd: 'Filter intensity',
  holdCompare: 'Hold to compare',
  hdr10Notice: 'Preview unavailable in HDR10 Video',
  bokehActiveNote: 'Portrait optical aperture · independent from Looks',
  bokehUsePortrait: 'Available in Portrait mode (pre-selected for Portrait)',
  lookPausedFmt: 'Paused in %1$s',
  pairPausedFmt: 'Uses %1$s only — Look paused',
  pairDoubleLutFmt: '2x LUT active: %1$s + Look (prefer Auto / Minimal)',
  pairDiffusionFmt: '1x LUT + soft highlights/zoom (%1$s)',
  pairHdrPlusFmt: '1x LUT + highlight roll-off (%1$s)',
  pairFilmFmt: '1x LUT + crisp shadows (%1$s)',
  pairActiveFmt: '1x LUT paired with %1$s',
  closeCd: 'Close effects panel',
  compassHudTitle: 'Compass & solar HUD',
  postprocEntries: [
    'Auto (W/O Stock · Clean HAL + LTM)',
    'Auto (W/ Stock · Native SuperRes/ISP)',
    'Natural ZSL (NR ZSL / Edge ZSL)',
    'Minimal ISP (NR Minimal / Edge Off)',
    'Detail HDR (RAW HDR / Low Halo)',
    'Pure ISP (MFNR Off / NR Off)',
    'Clean RAW Bayer (DNG -> Clean JPG)',
    'Disable Post Processing (MCF Off / Direct HAL)',
  ],
  profileShorts: ['Auto', 'Stock', 'Natural', 'Minimal', 'HDR', 'Pure ISP', 'Clean RAW', 'MCF Off'],
};

const LOCALE_STRINGS = {
  en: EN_STRINGS,
  es: {
    effectsLabel: 'Efectos y filtros',
    prefPostprocTitle: 'Perfil de posprocesado',
    catAll: 'Todo',
    catOptical: 'Óptica',
    catHdr: 'HDR+',
    catFilm: 'Film',
    catBokeh: 'Lentes Bokeh',
    lookNone: 'Original',
    bokehStock: 'Stock',
    intensityFmt: 'Intensidad %1$d%%',
    intensityCd: 'Intensidad del filtro',
    holdCompare: 'Mantener para comparar',
    hdr10Notice: 'Vista previa no disponible en video HDR10',
    bokehActiveNote: 'Apertura óptica en Retrato · independiente del Look',
    bokehUsePortrait: 'Usá el modo Retrato para aplicar este Bokeh',
    lookPausedFmt: 'Filtro en pausa en %1$s',
    pairPausedFmt: 'Solo %1$s activo — Filtro en pausa',
    pairDoubleLutFmt: 'Doble LUT activo: %1$s + Look (usá Auto / Mínimo)',
    pairDiffusionFmt: '1x LUT + altas luces suaves (%1$s)',
    pairHdrPlusFmt: '1x LUT + control de altas luces (%1$s)',
    pairFilmFmt: '1x LUT + sombras firmes (%1$s)',
    pairActiveFmt: '1x LUT combinado con %1$s',
    closeCd: 'Cerrar panel de efectos',
    compassHudTitle: 'Brújula y posición solar',
    postprocEntries: [
      'Auto (Sin Stock · HAL limpio + LTM)',
      'Auto (Con Stock · SuperRes/ISP nativo)',
      'ZSL Natural (NR ZSL / Nitidez ZSL)',
      'ISP Mínimo (NR Mínimo / Sin nitidez)',
      'Detail HDR (RAW HDR / Bajo halo)',
      'ISP Puro (Sin MFNR / Sin NR)',
      'RAW Bayer Limpio (DNG -> JPG limpio)',
      'Desactivar posprocesado (Sin MCF / HAL directo)',
    ],
    profileShorts: ['Auto', 'Stock', 'Natural', 'Mínimo', 'HDR', 'ISP Puro', 'RAW Limpio', 'Sin MCF'],
  },
  pt: {
    effectsLabel: 'Efeitos e filtros',
    prefPostprocTitle: 'Perfil de pós-processamento',
    catAll: 'Tudo',
    catOptical: 'Óptica',
    catHdr: 'HDR+',
    catFilm: 'Film',
    catBokeh: 'Bokeh',
    lookNone: 'Original',
    bokehStock: 'Original',
    intensityFmt: 'Intensidade %1$d%%',
    intensityCd: 'Intensidade do filtro',
    holdCompare: 'Segure para comparar',
    hdr10Notice: 'Prévia indisponível em vídeo HDR10',
    bokehActiveNote: 'Aplicado ao salvar no modo Retrato',
    bokehUsePortrait: 'Use o modo Retrato para aplicar este Bokeh',
    lookPausedFmt: 'Filtro pausado em %1$s',
    closeCd: 'Fechar painel de efeitos',
    postprocEntries: [
      'Auto (Sem Stock · HAL limpo + LTM)',
      'Auto (Com Stock · SuperRes/ISP nativo)',
      'ZSL Natural (NR ZSL / Nitidez ZSL)',
      'ISP Mínimo (NR Mínimo / Sem nitidez)',
      'Detail HDR (RAW HDR / Baixo halo)',
      'ISP Puro (Sem MFNR / Sem NR)',
      'RAW Bayer Limpo (DNG -> JPG limpo)',
      'Desativar pós-processamento (Sem MCF)',
    ],
    profileShorts: ['Auto', 'Stock', 'Natural', 'Mínimo', 'HDR', 'ISP Puro', 'RAW Limpo', 'Sem MCF'],
  },
  fr: {
    effectsLabel: 'Effets et filtres',
    prefPostprocTitle: 'Profil de post-traitement',
    catAll: 'Tout',
    catOptical: 'Optique',
    catHdr: 'HDR+',
    catFilm: 'Film',
    catBokeh: 'Bokeh',
    lookNone: 'Original',
    bokehStock: 'Standard',
    intensityFmt: 'Intensité %1$d%%',
    intensityCd: 'Intensité du filtre',
    holdCompare: 'Maintenir pour comparer',
    hdr10Notice: 'Aperçu indisponible en vidéo HDR10',
    bokehActiveNote: 'Appliqué à l’enregistrement en mode Portrait',
    bokehUsePortrait: 'Passez en mode Portrait pour ce Bokeh',
    lookPausedFmt: 'Filtre en pause en %1$s',
    closeCd: 'Fermer le panneau d’effets',
    postprocEntries: [
      'Auto (Sans Stock · HAL propre + LTM)',
      'Auto (Avec Stock · SuperRes/ISP natif)',
      'ZSL Naturel (NR ZSL / Netteté ZSL)',
      'ISP Minimal (NR Minimal / Netteté désact.)',
      'Detail HDR (RAW HDR / Faible halo)',
      'ISP Pur (Sans MFNR / Sans NR)',
      'RAW Bayer Propre (DNG -> JPG propre)',
      'Désactiver le post-traitement (Sans MCF)',
    ],
    profileShorts: ['Auto', 'Stock', 'Naturel', 'Minimal', 'HDR', 'ISP Pur', 'RAW Propre', 'Sans MCF'],
  },
  de: {
    effectsLabel: 'Effekte und Filter',
    prefPostprocTitle: 'Nachbearbeitungsprofil',
    catAll: 'Alle',
    catOptical: 'Optik',
    catHdr: 'HDR+',
    catFilm: 'Film',
    catBokeh: 'Bokeh',
    lookNone: 'Original',
    bokehStock: 'Standard',
    intensityFmt: 'Intensität %1$d%%',
    intensityCd: 'Filterintensität',
    holdCompare: 'Halten zum Vergleichen',
    hdr10Notice: 'Vorschau bei HDR10-Video nicht verfügbar',
    bokehActiveNote: 'Wird beim Speichern im Porträtmodus angewendet',
    bokehUsePortrait: 'Porträtmodus für dieses Bokeh wählen',
    lookPausedFmt: 'Filter pausiert in %1$s',
    closeCd: 'Effektpanel schließen',
    postprocEntries: [
      'Auto (Ohne Stock · Sauberer HAL + LTM)',
      'Auto (Mit Stock · Natives SuperRes/ISP)',
      'Natürliches ZSL (NR ZSL / Schärfe ZSL)',
      'Minimaler ISP (NR Minimal / Schärfe Aus)',
      'Detail HDR (RAW HDR / Geringer Halo)',
      'Reiner ISP (MFNR Aus / NR Aus)',
      'Sauberes RAW Bayer (DNG -> JPG)',
      'Nachbearbeitung deaktivieren (MCF Aus)',
    ],
    profileShorts: ['Auto', 'Stock', 'ZSL', 'Minimal', 'HDR', 'Reiner ISP', 'RAW', 'MCF Aus'],
  },
  it: {
    effectsLabel: 'Effetti e filtri',
    prefPostprocTitle: 'Profilo post-elaborazione',
    catAll: 'Tutti',
    catOptical: 'Ottica',
    catHdr: 'HDR+',
    catFilm: 'Film',
    catBokeh: 'Bokeh',
    lookNone: 'Originale',
    bokehStock: 'Predefinito',
    intensityFmt: 'Intensità %1$d%%',
    intensityCd: 'Intensità filtro',
    holdCompare: 'Tieni premuto per confrontare',
    hdr10Notice: 'Anteprima non disponibile in video HDR10',
    bokehActiveNote: 'Applicato al salvataggio in modalità Ritratto',
    bokehUsePortrait: 'Usa la modalità Ritratto per questo Bokeh',
    lookPausedFmt: 'Filtro in pausa in %1$s',
    closeCd: 'Chiudi pannello effetti',
    postprocEntries: [
      'Auto (Senza Stock · HAL pulito + LTM)',
      'Auto (Con Stock · SuperRes/ISP nativo)',
      'ZSL Naturale (NR ZSL / Nitidezza ZSL)',
      'ISP Minimo (NR Minimo / Nitidezza Off)',
      'Detail HDR (RAW HDR / Basso alone)',
      'ISP Puro (MFNR Off / NR Off)',
      'RAW Bayer Pulito (DNG -> JPG)',
      'Disattiva post-elaborazione (MCF Off)',
    ],
    profileShorts: ['Auto', 'Stock', 'ZSL', 'Minimo', 'HDR', 'ISP Puro', 'RAW Pulito', 'MCF Off'],
  },
  nl: {
    ...EN_STRINGS,
    effectsLabel: 'Effecten en filters',
    prefPostprocTitle: 'Nabewerkingsprofiel',
    catAll: 'Alles',
    catOptical: 'Optisch',
    lookNone: 'Origineel',
    bokehStock: 'Standaard',
    intensityFmt: 'Intensiteit %1$d%%',
    intensityCd: 'Filterintensiteit',
    holdCompare: 'Vasthouden om te vergelijken',
    hdr10Notice: 'Voorbeeld niet beschikbaar in HDR10-video',
    bokehActiveNote: 'Toegepast bij opslaan in Portretmodus',
    bokehUsePortrait: 'Gebruik Portretmodus voor Bokeh',
    lookPausedFmt: 'Gepauzeerd in %1$s',
    closeCd: 'Effectpaneel sluiten',
  },
  pl: {
    ...EN_STRINGS,
    effectsLabel: 'Efekty i filtry',
    prefPostprocTitle: 'Profil przetwarzania',
    catAll: 'Wszystko',
    catOptical: 'Optyka',
    lookNone: 'Oryginał',
    bokehStock: 'Domyślny',
    intensityFmt: 'Intensywność %1$d%%',
    intensityCd: 'Intensywność filtra',
    holdCompare: 'Przytrzymaj, aby porównać',
    hdr10Notice: 'Podgląd niedostępny w wideo HDR10',
    bokehActiveNote: 'Stosowane przy zapisie w trybie Portret',
    bokehUsePortrait: 'Użyj trybu Portret, aby włączyć Bokeh',
    lookPausedFmt: 'Wstrzymano w %1$s',
    closeCd: 'Zamknij panel efektów',
  },
  ru: {
    ...EN_STRINGS,
    effectsLabel: 'Эффекты и фильтры',
    prefPostprocTitle: 'Профиль постобработки',
    catAll: 'Все',
    catOptical: 'Оптика',
    lookNone: 'Оригинал',
    bokehStock: 'Сток',
    intensityFmt: 'Интенсивность %1$d%%',
    intensityCd: 'Интенсивность фильтра',
    holdCompare: 'Удерживайте для сравнения',
    hdr10Notice: 'Предпросмотр недоступен в HDR10-видео',
    bokehActiveNote: 'Применяется при сохранении в Портрете',
    bokehUsePortrait: 'Включите режим Портрет для Боке',
    lookPausedFmt: 'Пауза в %1$s',
    closeCd: 'Закрыть панель эффектов',
  },
  uk: {
    ...EN_STRINGS,
    effectsLabel: 'Ефекти та фільтри',
    prefPostprocTitle: 'Профіль постобробки',
    catAll: 'Усі',
    catOptical: 'Оптика',
    lookNone: 'Оригінал',
    bokehStock: 'Сток',
    intensityFmt: 'Інтенсивність %1$d%%',
    intensityCd: 'Інтенсивність фільтра',
    holdCompare: 'Утримуйте для порівняння',
    hdr10Notice: 'Попередній перегляд недоступний у HDR10',
    bokehActiveNote: 'Застосовується при збереженні в Портреті',
    bokehUsePortrait: 'Увімкніть режим Портрет для Боке',
    lookPausedFmt: 'Призупинено в %1$s',
    closeCd: 'Закрити панель ефектів',
  },
  tr: {
    ...EN_STRINGS,
    effectsLabel: 'Efektler ve filtreler',
    prefPostprocTitle: 'İşleme profili',
    catAll: 'Tümü',
    catOptical: 'Optik',
    lookNone: 'Orijinal',
    bokehStock: 'Varsayılan',
    intensityFmt: 'Yoğunluk %1$d%%',
    intensityCd: 'Filtre yoğunluğu',
    holdCompare: 'Karşılaştırmak için basılı tutun',
    hdr10Notice: 'HDR10 videoda önizleme kullanılamıyor',
    bokehActiveNote: 'Portre modunda kaydederken uygulanır',
    bokehUsePortrait: 'Bokeh için Portre moduna geçin',
    lookPausedFmt: '%1$s modunda duraklatıldı',
    closeCd: 'Efekt panelini kapat',
  },
  ar: {
    ...EN_STRINGS,
    effectsLabel: 'التأثيرات والفلاتر',
    prefPostprocTitle: 'ملف المعالجة اللاحقة',
    catAll: 'الكل',
    catOptical: 'بصري',
    lookNone: 'الأصلي',
    bokehStock: 'افتراضي',
    intensityFmt: 'الحدة %1$d%%',
    intensityCd: 'حدة الفلتر',
    holdCompare: 'اضغط مطولاً للمقارنة',
    hdr10Notice: 'المعاينة غير متوفرة في فيديو HDR10',
    bokehActiveNote: 'يُطبق عند الحفظ في وضع البورتريه',
    bokehUsePortrait: 'استخدم وضع البورتريه لتأثير البوكيه',
    lookPausedFmt: 'متوقف في %1$s',
    closeCd: 'إغلاق لوحة التأثيرات',
  },
  ja: {
    ...EN_STRINGS,
    effectsLabel: 'エフェクトとフィルター',
    prefPostprocTitle: '後処理プロファイル',
    catAll: 'すべて',
    catOptical: '光学',
    lookNone: 'オリジナル',
    bokehStock: '標準',
    intensityFmt: '強さ %1$d%%',
    intensityCd: 'フィルターの強さ',
    holdCompare: '長押しで比較',
    hdr10Notice: 'HDR10動画ではプレビュー不可',
    bokehActiveNote: 'ポートレート保存時に適用',
    bokehUsePortrait: 'ボケはポートレートモードで有効',
    lookPausedFmt: '%1$sでは一時停止中',
    closeCd: 'エフェクトパネルを閉じる',
  },
  ko: {
    ...EN_STRINGS,
    effectsLabel: '효과 및 필터',
    prefPostprocTitle: '후처리 프로필',
    catAll: '전체',
    catOptical: '광학',
    lookNone: '원본',
    bokehStock: '기본',
    intensityFmt: '강도 %1$d%%',
    intensityCd: '필터 강도',
    holdCompare: '길게 눌러 비교',
    hdr10Notice: 'HDR10 동영상에서는 미리보기 불가',
    bokehActiveNote: '인물 사진 저장 시 적용됨',
    bokehUsePortrait: '인물 사진 모드에서 보케 적용',
    lookPausedFmt: '%1$s에서 일시중지됨',
    closeCd: '효과 패널 닫기',
  },
  zh: {
    ...EN_STRINGS,
    effectsLabel: '效果与滤镜',
    prefPostprocTitle: '后期处理配置',
    catAll: '全部',
    catOptical: '光学',
    lookNone: '原图',
    bokehStock: '默认',
    intensityFmt: '强度 %1$d%%',
    intensityCd: '滤镜强度',
    holdCompare: '长按对比',
    hdr10Notice: 'HDR10 视频不支持预览',
    bokehActiveNote: '保存人像照片时应用',
    bokehUsePortrait: '请切换至人像模式以使用虚化',
    lookPausedFmt: '在 %1$s 中已暂停',
    closeCd: '关闭效果面板',
  },
  zhHant: {
    ...EN_STRINGS,
    effectsLabel: '效果與濾鏡',
    prefPostprocTitle: '後製處理設定',
    catAll: '全部',
    catOptical: '光學',
    lookNone: '原圖',
    bokehStock: '預設',
    intensityFmt: '強度 %1$d%%',
    intensityCd: '濾鏡強度',
    holdCompare: '長按對比',
    hdr10Notice: 'HDR10 影片不支援預覽',
    bokehActiveNote: '於人像模式儲存時套用',
    bokehUsePortrait: '請切換至人像模式以使用散景',
    lookPausedFmt: '於 %1$s 中暫停',
    closeCd: '關閉效果面板',
  },
  hi: {
    ...EN_STRINGS,
    effectsLabel: 'इफ़ेक्ट और फ़िल्टर',
    prefPostprocTitle: 'पोस्ट-प्रोसेसिंग प्रोफ़ाइल',
    catAll: 'सभी',
    catOptical: 'ऑप्टिकल',
    lookNone: 'मूल',
    bokehStock: 'स्टॉक',
    intensityFmt: 'तीव्रता %1$d%%',
    intensityCd: 'फ़िल्टर तीव्रता',
    holdCompare: 'तुलना के लिए दबाए रखें',
    hdr10Notice: 'HDR10 वीडियो में पूर्वावलोकन उपलब्ध नहीं',
    bokehActiveNote: 'पोर्ट्रेट मोड में सेव करते समय लागू होगा',
    bokehUsePortrait: 'बोकेह के लिए पोर्ट्रेट मोड का उपयोग करें',
    lookPausedFmt: '%1$s में विराम',
    closeCd: 'इफ़ेक्ट पैनल बंद करें',
  },
  in: {
    ...EN_STRINGS,
    effectsLabel: 'Efek dan filter',
    prefPostprocTitle: 'Profil pascapemrosesan',
    catAll: 'Semua',
    catOptical: 'Optik',
    lookNone: 'Asli',
    bokehStock: 'Bawaan',
    intensityFmt: 'Intensitas %1$d%%',
    intensityCd: 'Intensitas filter',
    holdCompare: 'Tahan untuk membandingkan',
    hdr10Notice: 'Pratinjau tidak tersedia di Video HDR10',
    bokehActiveNote: 'Diterapkan saat menyimpan di mode Potret',
    bokehUsePortrait: 'Gunakan mode Potret untuk Bokeh ini',
    lookPausedFmt: 'Dijeda di %1$s',
    closeCd: 'Tutup panel efek',
  },
  vi: {
    ...EN_STRINGS,
    effectsLabel: 'Hiệu ứng và bộ lọc',
    prefPostprocTitle: 'Cấu hình hậu kỳ',
    catAll: 'Tất cả',
    catOptical: 'Quang học',
    lookNone: 'Gốc',
    bokehStock: 'Mặc định',
    intensityFmt: 'Cường độ %1$d%%',
    intensityCd: 'Cường độ bộ lọc',
    holdCompare: 'Nhấn giữ để so sánh',
    hdr10Notice: 'Không hỗ trợ xem trước trong Video HDR10',
    bokehActiveNote: 'Áp dụng khi lưu ở chế độ Chân dung',
    bokehUsePortrait: 'Dùng chế độ Chân dung để áp dụng Bokeh',
    lookPausedFmt: 'Tạm dừng ở %1$s',
    closeCd: 'Đóng bảng hiệu ứng',
  },
  th: {
    ...EN_STRINGS,
    effectsLabel: 'เอฟเฟกต์และฟิลเตอร์',
    prefPostprocTitle: 'โปรไฟล์การประมวลผลภาพ',
    catAll: 'ทั้งหมด',
    catOptical: 'ออปติคอล',
    lookNone: 'ต้นฉบับ',
    bokehStock: 'มาตรฐาน',
    intensityFmt: 'ความเข้ม %1$d%%',
    intensityCd: 'ความเข้มฟิลเตอร์',
    holdCompare: 'แตะค้างเพื่อเปรียบเทียบ',
    hdr10Notice: 'ไม่รองรับตัวอย่างในวิดีโอ HDR10',
    bokehActiveNote: 'ใช้เมื่อบันทึกในโหมดภาพบุคคล',
    bokehUsePortrait: 'ใช้โหมดภาพบุคคลสำหรับโบเก้',
    lookPausedFmt: 'หยุดชั่วคราวใน %1$s',
    closeCd: 'ปิดแผงเอฟเฟกต์',
  },
  cs: {
    ...EN_STRINGS,
    effectsLabel: 'Efekty a filtry',
    prefPostprocTitle: 'Profil zpracování obrazu',
    catAll: 'Vše',
    catOptical: 'Optika',
    lookNone: 'Originál',
    intensityFmt: 'Intenzita %1$d%%',
    holdCompare: 'Podržte pro porovnání',
    bokehActiveNote: 'Použije se při uložení v režimu Portrét',
    bokehUsePortrait: 'Pro Bokeh přepněte do režimu Portrét',
    lookPausedFmt: 'Pozastaveno v %1$s',
  },
  sk: {
    ...EN_STRINGS,
    effectsLabel: 'Efekty a filtre',
    prefPostprocTitle: 'Profil spracovania obrazu',
    catAll: 'Všetko',
    catOptical: 'Optika',
    lookNone: 'Originál',
    intensityFmt: 'Intenzita %1$d%%',
    holdCompare: 'Podržte na porovnanie',
    bokehActiveNote: 'Použije sa pri uložení v režime Portrét',
    bokehUsePortrait: 'Pre Bokeh prepnite do režimu Portrét',
    lookPausedFmt: 'Pozastavené v %1$s',
  },
  ro: {
    ...EN_STRINGS,
    effectsLabel: 'Efecte și filtre',
    prefPostprocTitle: 'Profil post-procesare',
    catAll: 'Toate',
    catOptical: 'Optică',
    lookNone: 'Original',
    intensityFmt: 'Intensitate %1$d%%',
    holdCompare: 'Țineți apăsat pentru comparație',
    bokehActiveNote: 'Aplicat la salvare în modul Portret',
    bokehUsePortrait: 'Folosiți modul Portret pentru Bokeh',
    lookPausedFmt: 'Întrerupt în %1$s',
  },
  hu: {
    ...EN_STRINGS,
    effectsLabel: 'Effektek és szűrők',
    prefPostprocTitle: 'Utófeldolgozási profil',
    catAll: 'Összes',
    catOptical: 'Optika',
    lookNone: 'Eredeti',
    intensityFmt: 'Intenzitás %1$d%%',
    holdCompare: 'Tartsa nyomva az összehasonlításhoz',
    bokehActiveNote: 'Portré módban mentéskor alkalmazva',
    bokehUsePortrait: 'Bokeh-hoz váltson Portré módra',
    lookPausedFmt: 'Szüneteltetve: %1$s',
  },
  ca: {
    ...EN_STRINGS,
    effectsLabel: 'Efectes i filtres',
    prefPostprocTitle: 'Perfil de postprocessament',
    catAll: 'Tot',
    catOptical: 'Òptica',
    lookNone: 'Original',
    intensityFmt: 'Intensitat %1$d%%',
    holdCompare: 'Manteniu per comparar',
    bokehActiveNote: 'S’aplica en desar en mode Retrat',
    bokehUsePortrait: 'Canvieu al mode Retrat per a aquest Bokeh',
    lookPausedFmt: 'En pausa a %1$s',
  },
  sv: { ...EN_STRINGS, effectsLabel: 'Effekter och filter', prefPostprocTitle: 'Efterbehandlingsprofil', catAll: 'Alla', lookNone: 'Original', intensityFmt: 'Intensitet %1$d%%' },
  da: { ...EN_STRINGS, effectsLabel: 'Effekter og filtre', prefPostprocTitle: 'Efterbehandlingsprofil', catAll: 'Alle', lookNone: 'Original', intensityFmt: 'Intensitet %1$d%%' },
  nb: { ...EN_STRINGS, effectsLabel: 'Effekter og filtre', prefPostprocTitle: 'Etterbehandlingsprofil', catAll: 'Alle', lookNone: 'Original', intensityFmt: 'Intensitet %1$d%%' },
  fi: { ...EN_STRINGS, effectsLabel: 'Tehosteet ja suodattimet', prefPostprocTitle: 'Jälkikäsittelyprofiili', catAll: 'Kaikki', lookNone: 'Alkuperäinen', intensityFmt: 'Voimakkuus %1$d%%' },
  el: { ...EN_STRINGS, effectsLabel: 'Εφέ και φίλτρα', prefPostprocTitle: 'Προφίλ επεξεργασίας', catAll: 'Όλα', lookNone: 'Αρχικό', intensityFmt: 'Ένταση %1$d%%' },
  hr: { ...EN_STRINGS, effectsLabel: 'Efekti i filtri', prefPostprocTitle: 'Profil obrade slike', catAll: 'Sve', lookNone: 'Izvorno', intensityFmt: 'Intenzitet %1$d%%' },
  sl: { ...EN_STRINGS, effectsLabel: 'Učinki in filtri', prefPostprocTitle: 'Profil obdelave slike', catAll: 'Vse', lookNone: 'Izvirnik', intensityFmt: 'Intenzivnost %1$d%%' },
  sr: { ...EN_STRINGS, effectsLabel: 'Ефекти и филтери', prefPostprocTitle: 'Профил обраде', catAll: 'Све', lookNone: 'Оригинал', intensityFmt: 'Интензитет %1$d%%' },
  bg: { ...EN_STRINGS, effectsLabel: 'Ефекти и филтри', prefPostprocTitle: 'Профил за обработка', catAll: 'Всички', lookNone: 'Оригинал', intensityFmt: 'Интензитет %1$d%%' },
};

const NON_LANGUAGE_VALUES = /^values-(?:h\d+|w\d+|sw\d+|land|port|small|large|xlarge|hdpi|mdpi|xhdpi|xxhdpi|xxxhdpi|night|watch|ldrtl)/;

export function resolveLocaleStrings(dirName) {
  if (dirName === 'values' || dirName.startsWith('values-en')) return LOCALE_STRINGS.en;
  if (dirName === 'values-zh-rTW' || dirName === 'values-zh-rHK') return LOCALE_STRINGS.zhHant;
  if (dirName.startsWith('values-zh')) return LOCALE_STRINGS.zh;
  if (dirName === 'values-b+sr+Latn') return { ...EN_STRINGS, effectsLabel: 'Efekti i filteri', prefPostprocTitle: 'Profil obrade', catAll: 'Sve', lookNone: 'Original', intensityFmt: 'Intenzitet %1$d%%' };
  const langMatch = /^values-(?:b\+)?([a-z]{2,3})(?:[-+]|$)/.exec(dirName);
  if (!langMatch) return null;
  return LOCALE_STRINGS[langMatch[1]] || LOCALE_STRINGS.en;
}

function escapeXml(value) {
  return String(value)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}

function buildPortEffectsXml(t) {
  const lines = [
    '<?xml version="1.0" encoding="utf-8"?>',
    '<resources>',
    `    <string name="port_pref_postproc_title">${escapeXml(t.prefPostprocTitle)}</string>`,
    `    <string name="port_effects_title">${escapeXml(t.effectsLabel)}</string>`,
    `    <string name="port_cat_all">${escapeXml(t.catAll)}</string>`,
    `    <string name="port_cat_optical">${escapeXml(t.catOptical)}</string>`,
    `    <string name="port_cat_hdr">${escapeXml(t.catHdr)}</string>`,
    `    <string name="port_cat_film">${escapeXml(t.catFilm)}</string>`,
    `    <string name="port_cat_bokeh">${escapeXml(t.catBokeh)}</string>`,
    `    <string name="port_look_none">${escapeXml(t.lookNone)}</string>`,
    `    <string name="port_bokeh_stock">${escapeXml(t.bokehStock)}</string>`,
    `    <string name="port_intensity_fmt">${escapeXml(t.intensityFmt)}</string>`,
    `    <string name="port_intensity_cd">${escapeXml(t.intensityCd)}</string>`,
    `    <string name="port_hold_compare">${escapeXml(t.holdCompare)}</string>`,
    `    <string name="port_hdr10_notice">${escapeXml(t.hdr10Notice)}</string>`,
    `    <string name="port_bokeh_portrait_active">${escapeXml(t.bokehActiveNote)}</string>`,
    `    <string name="port_bokeh_use_portrait">${escapeXml(t.bokehUsePortrait)}</string>`,
    `    <string name="port_look_paused_fmt">${escapeXml(t.lookPausedFmt)}</string>`,
    `    <string name="port_pair_paused_fmt">${escapeXml(t.pairPausedFmt ?? EN_STRINGS.pairPausedFmt)}</string>`,
    `    <string name="port_pair_double_lut_fmt">${escapeXml(t.pairDoubleLutFmt ?? EN_STRINGS.pairDoubleLutFmt)}</string>`,
    `    <string name="port_pair_diffusion_fmt">${escapeXml(t.pairDiffusionFmt ?? EN_STRINGS.pairDiffusionFmt)}</string>`,
    `    <string name="port_pair_hdrplus_fmt">${escapeXml(t.pairHdrPlusFmt ?? EN_STRINGS.pairHdrPlusFmt)}</string>`,
    `    <string name="port_pair_film_fmt">${escapeXml(t.pairFilmFmt ?? EN_STRINGS.pairFilmFmt)}</string>`,
    `    <string name="port_pair_active_fmt">${escapeXml(t.pairActiveFmt ?? EN_STRINGS.pairActiveFmt)}</string>`,
    `    <string name="port_close_cd">${escapeXml(t.closeCd)}</string>`,
    `    <string name="port_compass_hud_title">${escapeXml(t.compassHudTitle ?? EN_STRINGS.compassHudTitle)}</string>`,
    '    <string-array name="port_postproc_entries">',
    ...t.postprocEntries.map((entry) => `        <item>${escapeXml(entry)}</item>`),
    '    </string-array>',
    '    <string-array name="port_profile_shorts">',
    ...t.profileShorts.map((entry) => `        <item>${escapeXml(entry)}</item>`),
    '    </string-array>',
    '</resources>',
    '',
  ];
  return lines.join('\n');
}

function replaceUnique(source, needle, replacement) {
  if (source.split(needle).length !== 2) throw new Error('Unexpected preview shader structure');
  return source.replace(needle, replacement);
}

export function stagePreviewEffects(stage) {
  const resources = path.join(stage, 'res');
  const baseDrawableDir = path.join(resources, 'drawable');
  fs.mkdirSync(baseDrawableDir, { recursive: true });
  for (const [badgeName, xml] of Object.entries(BRAND_BADGES)) {
    fs.writeFileSync(path.join(baseDrawableDir, `${badgeName}.xml`), xml);
  }

  for (const entry of fs.readdirSync(resources, { withFileTypes: true })) {
    if (!entry.isDirectory()) continue;
    if (/^drawable(?:-|$)/.test(entry.name)) {
      const target = path.join(resources, entry.name, 'ic_google_lens.xml');
      if (fs.existsSync(target)) fs.writeFileSync(target, icon);
    }
    if (/^values(?:-|$)/.test(entry.name) && !NON_LANGUAGE_VALUES.test(entry.name)) {
      const locale = resolveLocaleStrings(entry.name);
      if (!locale) continue;
      const dir = path.join(resources, entry.name);
      fs.writeFileSync(path.join(dir, 'port_effects.xml'), buildPortEffectsXml(locale));
      const target = path.join(dir, 'strings.xml');
      if (!fs.existsSync(target)) continue;
      const strings = fs.readFileSync(target, 'utf8');
      let staged = strings.replace(
        /(<string name="main_setting_google_lens">)[^<]*(<\/string>)/g,
        `$1${escapeXml(locale.effectsLabel)}$2`,
      );
      // smali_patches_cam5.json replaces exact English talkback in values and values-es after staging.
      if (entry.name !== 'values' && entry.name !== 'values-es') {
        staged = staged.replace(
          /(<string name="talkback_google_lens">)[^<]*(<\/string>)/g,
          `$1${escapeXml(locale.effectsLabel)}$2`,
        );
      }
      if (staged !== strings) fs.writeFileSync(target, staged);
    }
  }
  for (const name of ['camera_preview', 'yuv_rgb']) {
    const vertex = path.join(resources, 'raw', name + '_glvs.txt');
    const fragment = path.join(resources, 'raw', name + '_glfs.txt');
    const vs = fs.readFileSync(vertex, 'utf8').replace(/\r\n/g, '\n');
    fs.writeFileSync(vertex, 'varying highp vec2 v_LookQuad;\n' +
      replaceUnique(vs, 'gl_Position =', 'v_LookQuad = a_Position.xy;\n    gl_Position ='));
    const fsSource = fs.readFileSync(fragment, 'utf8').replace(/\r\n/g, '\n');
    const main = fsSource.indexOf('void main()');
    if (main < 0) throw new Error('Missing preview fragment main');
    const headers = fsSource.slice(0, main);
    const body = fsSource.slice(main);
    if (name === 'camera_preview') {
      const sample = 'vec3 sampleLookSource(vec2 uv) { return texture2D(u_Texture, uv).rgb; }\n';
      const edited = replaceUnique(body, 'gl_FragColor = texture2D(u_Texture, v_TextureCoord) * u_Alpha;',
        'vec4 source = texture2D(u_Texture, v_TextureCoord);\n    gl_FragColor = vec4(applyPreviewLook(source.rgb, v_TextureCoord), source.a) * u_Alpha;');
      fs.writeFileSync(fragment, headers + sample + effects + edited);
    } else {
      const sample = replaceUnique(replaceUnique(body, 'void main() {',
        'vec3 sampleLookSource(vec2 uv) {'), 'gl_FragColor = vec4(r,g,b,1.0) * u_Opacity;',
      'return vec3(r, g, b);').replace(/\bv_textCoord\b/g, 'uv');
      fs.writeFileSync(fragment, headers + sample + effects +
        'void main() { gl_FragColor = vec4(applyPreviewLook(sampleLookSource(v_textCoord), v_textCoord), 1.0) * u_Opacity; }\n');
    }
  }
}
