import fs from 'node:fs';
import path from 'node:path';
import { pathToFileURL } from 'node:url';

const SIZE = 33;
const clamp = value => Math.min(1, Math.max(0, value));
const smooth = value => {
  const t = clamp(value);
  return t * t * (3 - 2 * t);
};

// Curve parameters are contrast, midtone exponent, saturation, black lift,
// red warmth, blue warmth and saturation protection for orange hues.
const specifications = [
  ['Leica Authentic', 'Optical', [1.16, 1.04, 0.91, 0, 0.047, -0.033, 0.45]],
  ['Leica Vibrant', 'Optical', [1.07, 0.92, 1.18, 0, 0.018, 0.008, 0.80]],
  ['Leica B&W HC', 'Optical', [1.28, 1.02, 0, 0, 0, 0, 0]],
  ['Zeiss Natural', 'Optical', [1.01, 1, 1.025, 0, 0, 0, 0.85]],
  ['Zeiss T* Textured', 'Optical', [1.11, 1.02, 1.08, 0, 0.005, -0.003, 0.72]],
  ['Google HDR+', 'HDR+', [1.02, 0.89, 1.045, 0, 0, 0.014, 1]],
  ['Black Pro-Mist 1/4', 'Film', [0.95, 0.98, 0.96, 0.035, 0.004, 0, 0.65]],
  ['CineStill 800T', 'Film', [1.08, 1, 0.95, 0.014, -0.042, 0.067, 0.60]],
  ['Fujifilm Classic Chrome', 'Film', [1.15, 1.03, 0.78, 0.01, 0.009, 0.019, 0.55]],
  ['Fujifilm Nostalgic Neg.', 'Film', [1.08, 0.96, 0.98, 0.025, 0.065, -0.053, 0.55]],
  ['Kodak Portra 400', 'Film', [0.94, 0.96, 0.87, 0.038, 0.028, -0.026, 0.78]],
  ['Ricoh GR Positive Film', 'Film', [1.20, 1.06, 1.13, 0, 0.019, -0.018, 0.60]],
  ['2000s Y2K CCD Digicam', 'Film', [1.24, 0.93, 1.23, 0.018, -0.018, 0.058, 0.25]],
];

export const LOOKS = Object.freeze(specifications.map(([name, category], index) =>
  Object.freeze({ id: index + 1, name, category })));

function grade(r, g, b, id, parameters) {
  const [contrast, exponent, saturation, lift, red, blue, protection] = parameters;
  const monochrome = id === 3;
  const y = monochrome ? 0.38 * r + 0.56 * g + 0.06 * b : 0.2126 * r + 0.7152 * g + 0.0722 * b;
  const skin = smooth((r - g) * 12) * smooth((g - b) * 14)
    * (1 - smooth((r - g - 0.23) * 6));
  const base = y ** (exponent + (1 - exponent) * skin * protection * 0.65);
  const tone = lift + (1 - lift) * clamp(base + (contrast - 1) * base * (1 - base) * (4 * base - 2));
  let chroma = saturation + (1 - saturation) * skin * protection;
  if (id === 1 || id === 9) chroma *= 1 - 0.15 * smooth((g - Math.max(r, b)) * 5);
  const tint = 4 * base * (1 - base) * (1 - skin * protection);
  if (monochrome) return [tone, tone, tone];
  return [
    tone + (r - y) * chroma + red * tint,
    tone + (g - y) * chroma - (red + blue) * tint * 0.12,
    tone + (b - y) * chroma + blue * tint,
  ];
}

// RGB8 with R increasing fastest, then G, then B. Slice b occupies
// rows b*33 through b*33+32 in the equivalent vertical GL texture.
export function generateClut(id) {
  const spec = specifications[id - 1];
  if (!Number.isInteger(id) || !spec) throw new RangeError('Invalid look preset ID');
  const cube = Buffer.alloc(SIZE ** 3 * 3);
  let offset = 0;
  for (let blue = 0; blue < SIZE; blue++) {
    for (let green = 0; green < SIZE; green++) {
      for (let red = 0; red < SIZE; red++) {
        const rgb = grade(red / 32, green / 32, blue / 32, id, spec[2]);
        for (const value of rgb) cube[offset++] = Math.round(255 * clamp(value));
      }
    }
  }
  return cube;
}

export function writeLookLuts(directory) {
  fs.mkdirSync(directory, { recursive: true });
  for (const { id } of LOOKS) {
    fs.writeFileSync(path.join(directory, id + '.clut'), generateClut(id));
  }
}

if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) {
  if (!process.argv[2]) throw new Error('Usage: node scripts/generate_look_luts.mjs <output-directory>');
  writeLookLuts(process.argv[2]);
}
