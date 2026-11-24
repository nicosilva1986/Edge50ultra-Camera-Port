// SPDX-License-Identifier: MIT
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import { mkdtempSync, readFileSync, readdirSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { dirname, join } from 'node:path';
import { after, before, test } from 'node:test';
import { fileURLToPath } from 'node:url';
import { resolveJava } from '../scripts/env_paths.mjs';

const source = fileURLToPath(new URL(
  '../patches/custom_imaging_java/src/com/motorola/camera/custom/CompassSolarHelper.java',
  import.meta.url,
));
const java = resolveJava();
const javac = join(dirname(java), process.platform === 'win32' ? 'javac.exe' : 'javac');

const S2 = Math.SQRT1_2;
const SIN15 = Math.sin(Math.PI / 12);
const COS15 = Math.cos(Math.PI / 12);

const probeSource = `
public final class CompassProbe {
    public static void main(String[] args) throws Exception {
        String[] lines = args[0].split("\\n", -1);
        for (String raw : lines) {
            if (raw.isEmpty()) continue;
            String[] p = raw.split(" ", -1);
            String op = p[0];
            if (op.equals("R")) {
                float[] vector = new float[p[1].equals("4") ? 4 : 3];
                vector[0] = Float.parseFloat(p[2]);
                vector[1] = Float.parseFloat(p[3]);
                vector[2] = Float.parseFloat(p[4]);
                if (vector.length == 4) vector[3] = Float.parseFloat(p[5]);
                com.motorola.camera.custom.CompassSolarHelper.OrientationReading reading =
                        com.motorola.camera.custom.CompassSolarHelper.computeOrientation(
                                vector, Integer.parseInt(p[1]), Integer.parseInt(p[6]),
                                p[7].equals("1"), Integer.parseInt(p[8]), Long.parseLong(p[9]));
                System.out.println("R " + reading.headingDeg + " " + reading.pitchDeg + " "
                        + reading.rollDeg + " " + reading.accuracy + " " + reading.timestampNs);
            } else if (op.equals("N")) {
                float[] vector = p[1].equals("short") ? new float[] {0f, 0f} : null;
                com.motorola.camera.custom.CompassSolarHelper.OrientationReading reading =
                        com.motorola.camera.custom.CompassSolarHelper.computeOrientation(
                                vector, Integer.parseInt(p[2]), 0, false,
                                Integer.parseInt(p[3]), Long.parseLong(p[4]));
                System.out.println("N " + reading.headingDeg + " " + reading.pitchDeg + " "
                        + reading.rollDeg + " " + reading.accuracy + " " + reading.timestampNs);
            } else if (op.equals("S")) {
                com.motorola.camera.custom.CompassSolarHelper.SolarPosition sun =
                        com.motorola.camera.custom.CompassSolarHelper.computeSolarPosition(
                                Double.parseDouble(p[1]), Double.parseDouble(p[2]), Long.parseLong(p[3]));
                System.out.println("S " + sun.azimuthDeg + " " + sun.elevationDeg);
            } else if (op.equals("C")) {
                System.out.println("C " + com.motorola.camera.custom.CompassSolarHelper.formatCardinal(
                        Double.parseDouble(p[1])));
            } else if (op.equals("L")) {
                System.out.println("L " + com.motorola.camera.custom.CompassSolarHelper.formatHeadingLabel(
                        Double.parseDouble(p[1])));
            } else if (op.equals("A")) {
                System.out.println("A " + com.motorola.camera.custom.CompassSolarHelper.angularSeparationDeg(
                        Double.parseDouble(p[1]), Double.parseDouble(p[2]),
                        Double.parseDouble(p[3]), Double.parseDouble(p[4])));
            } else if (op.equals("D")) {
                System.out.println("D " + com.motorola.camera.custom.CompassSolarHelper.horizontalAzimuthDeltaDeg(
                        Double.parseDouble(p[1]), Double.parseDouble(p[2])));
            } else if (op.equals("E")) {
                System.out.println("E " + com.motorola.camera.custom.CompassSolarHelper.computeEv100(
                        Long.parseLong(p[1]), Integer.parseInt(p[2]), Float.parseFloat(p[3])));
            } else if (op.equals("B")) {
                boolean gate = com.motorola.camera.custom.CompassSolarHelper.isPhysicalOutdoorBacklit(
                        Double.parseDouble(p[1]), Double.parseDouble(p[2]),
                        Double.parseDouble(p[3]), Integer.parseInt(p[4]));
                System.out.println("B " + (gate ? 1 : 0));
            } else if (op.equals("X")) {
                String rational = com.motorola.camera.custom.CompassSolarHelper.formatExifDirection(
                        Double.parseDouble(p[1]));
                System.out.println("X " + (rational == null ? "null" : rational));
            } else if (op.equals("K")) {
                System.out.println("K " + com.motorola.camera.custom.CompassSolarHelper.DEFAULT_OUTDOOR_EV100);
            } else {
                throw new IllegalArgumentException(op);
            }
        }
    }
}
`;

let work;

function run(executable, args, timeout = 120_000) {
  const result = spawnSync(executable, args, { encoding: 'utf8', timeout, windowsHide: true });
  assert.ifError(result.error);
  assert.equal(result.status, 0, [executable, ...args, result.stdout, result.stderr].join('\n'));
  return result.stdout;
}

function probe(lines) {
  const stdout = run(java, [
    '-Dfile.encoding=UTF-8', '-Dstdout.encoding=UTF-8', '-cp', work, 'CompassProbe', lines.join('\n'),
  ]);
  return stdout.split(/\r?\n/).filter((line) => line.length > 0);
}

function nums(line) {
  return line.split(' ').slice(1).map(Number);
}

function near(actual, expected, tolerance, label) {
  assert.ok(Number.isFinite(actual), `${label} is not finite: ${actual}`);
  assert.ok(Math.abs(actual - expected) <= tolerance,
    `${label}: got ${actual}, expected ${expected} ± ${tolerance}`);
}

function orient(q1, q2, q3, q0, len, display, front, accuracy = 3, timestamp = 1000) {
  const line = probe([
    `R ${len} ${q1} ${q2} ${q3} ${q0} ${display} ${front} ${accuracy} ${timestamp}`,
  ])[0];
  assert.equal(line.startsWith('R '), true, line);
  const [heading, pitch, roll, acc, ts] = nums(line);
  return { heading, pitch, roll, acc, ts };
}

function expectLook(reading, heading, pitch, roll, label) {
  near(reading.heading, heading, 0.05, `${label} heading`);
  near(reading.pitch, pitch, 0.05, `${label} pitch`);
  near(reading.roll, roll, 0.05, `${label} roll`);
}

function dayOfYear(epochMs) {
  const year = new Date(epochMs).getUTCFullYear();
  return (epochMs - Date.UTC(year, 0, 1)) / 86400000 + 1;
}

function cooperDeclinationDeg(epochMs) {
  const b = (2 * Math.PI / 365) * (dayOfYear(epochMs) - 81);
  return 23.45 * Math.sin(b);
}

function spencerEquationOfTimeMin(epochMs) {
  const b = (2 * Math.PI / 365) * (dayOfYear(epochMs) - 81);
  return 9.87 * Math.sin(2 * b) - 7.53 * Math.cos(b) - 1.5 * Math.sin(b);
}

function geometricElevationDeg(latDeg, lonDeg, epochMs) {
  const dec = cooperDeclinationDeg(epochMs) * Math.PI / 180;
  const utcMin = ((epochMs % 86400000) + 86400000) % 86400000 / 60000;
  let solar = utcMin + spencerEquationOfTimeMin(epochMs) + 4 * lonDeg;
  solar -= 1440 * Math.floor(solar / 1440);
  const ha = (solar / 4 - 180) * Math.PI / 180;
  const lat = latDeg * Math.PI / 180;
  const sinEl = Math.sin(lat) * Math.sin(dec) + Math.cos(lat) * Math.cos(dec) * Math.cos(ha);
  return Math.asin(Math.min(1, Math.max(-1, sinEl))) * 180 / Math.PI;
}

function meanSolarNoonUtcMin(lonDeg) {
  let minutes = 720 - 4 * lonDeg;
  minutes %= 1440;
  if (minutes < 0) minutes += 1440;
  return minutes;
}

function scanSun(lat, lon, centerMs, halfWindowMs, stepMs) {
  const start = centerMs - halfWindowMs;
  const count = Math.floor((halfWindowMs * 2) / stepMs) + 1;
  const lines = [];
  for (let i = 0; i < count; i += 1) lines.push(`S ${lat} ${lon} ${start + i * stepMs}`);
  const rows = probe(lines).map((line, index) => {
    assert.equal(line.startsWith('S '), true, line);
    const [azimuth, elevation] = nums(line);
    return { azimuth, elevation, epochMs: start + index * stepMs };
  });
  let peak = rows[0];
  for (const row of rows) if (row.elevation > peak.elevation) peak = row;
  return { rows, peak };
}

function azimuthFromNorth(deg) {
  const wrapped = ((deg % 360) + 360) % 360;
  return Math.min(wrapped, 360 - wrapped);
}

function azimuthFrom(deg, target) {
  const wrapped = ((deg - target) % 360 + 360) % 360;
  return Math.min(wrapped, 360 - wrapped);
}

before(() => {
  const text = readFileSync(source, 'utf8');
  assert.equal(/\bimport\s+/.test(text), false);
  assert.equal(text.includes('android.'), false);
  work = mkdtempSync(join(tmpdir(), 'compass-solar-'));
  run(javac, ['--release', '11', '-d', work, source]);
  const classes = readdirSync(join(work, 'com/motorola/camera/custom'))
    .filter((name) => name.startsWith('CompassSolarHelper'));
  assert.ok(classes.length >= 3, classes.join(','));
  for (const name of classes) {
    const bytecode = readFileSync(join(work, 'com/motorola/camera/custom', name));
    assert.equal(bytecode.readUInt16BE(0), 0xCAFE, name);
    assert.equal(bytecode.readUInt16BE(6), 55, name);
  }
  const harness = join(work, 'CompassProbe.java');
  writeFileSync(harness, probeSource);
  run(javac, ['--release', '11', '-cp', work, '-d', work, harness]);
});

after(() => {
  if (work) rmSync(work, { recursive: true, force: true });
});

const SIN60 = Math.sin(Math.PI / 3);
const COS60 = Math.cos(Math.PI / 3);
const SIN30 = Math.sin(Math.PI / 6);
const COS30 = Math.cos(Math.PI / 6);

test('Android ENU rotation vector: upright portrait N/E/S/W and flat zenith/nadir pose', () => {
  const north = orient(S2, 0, 0, S2, 4, 0, 0);
  expectLook(north, 0, 0, 0, 'rear upright north');
  const north3 = orient(S2, 0, 0, 0, 3, 0, 0);
  expectLook(north3, 0, 0, 0, 'rear upright north 3-vector');
  expectLook(orient(0.5, -0.5, -0.5, 0.5, 4, 0, 0), 90, 0, 0, 'rear upright east');
  expectLook(orient(0.5, -0.5, -0.5, 0, 3, 0, 0), 90, 0, 0, 'rear upright east 3-vector');
  expectLook(orient(0, -S2, -S2, 0, 4, 0, 0), 180, 0, 0, 'rear upright south');
  expectLook(orient(0.5, 0.5, 0.5, 0.5, 4, 0, 0), 270, 0, 0, 'rear upright west');
  expectLook(orient(1.5, -1.5, -1.5, 1.5, 4, 0, 0), 90, 0, 0, 'unnormalized east');
  const flatRear = orient(0, 0, 0, 1, 4, 0, 0);
  near(flatRear.heading, 0, 0.05, 'flat rear heading fallback');
  near(flatRear.pitch, -90, 0.05, 'flat rear pitch down');
  const flatFront = orient(0, 0, 0, 1, 4, 0, 1);
  near(flatFront.pitch, 90, 0.05, 'flat front pitch up');
});

test('pitch is positive looking up, front camera flips heading by 180 and reverses pitch', () => {
  expectLook(orient(SIN60, 0, 0, COS60, 4, 0, 0), 0, 30, 0, 'rear pitched up');
  expectLook(orient(SIN30, 0, 0, COS30, 4, 0, 0), 0, -30, 0, 'rear pitched down');
  expectLook(orient(S2, 0, 0, S2, 4, 0, 1), 180, 0, 0, 'front north device');
  expectLook(orient(SIN60, 0, 0, COS60, 4, 0, 1), 180, -30, 0, 'front while rear looks up');
  expectLook(orient(SIN30, 0, 0, COS30, 4, 0, 1), 180, 30, 0, 'front while rear looks down');
  expectLook(orient(0.5, -0.5, -0.5, 0.5, 4, 0, 1), 270, 0, 0, 'front while rear looks east');
});

test('display rotation changes roll and leaves the optical axis alone', () => {
  expectLook(orient(S2, 0, 0, S2, 4, 90, 0), 0, 0, 90, 'display 90');
  expectLook(orient(S2, 0, 0, S2, 4, 270, 0), 0, 0, -90, 'display 270');
  expectLook(orient(S2, 0, 0, S2, 4, 180, 0), 0, 0, 180, 'display 180');
  expectLook(orient(0.5, -0.5, -0.5, 0.5, 4, 90, 0), 90, 0, 90, 'east display 90');
  expectLook(orient(0.5, -0.5, -0.5, 0.5, 4, 270, 1), 270, 0, -90, 'front east display 270');
  expectLook(orient(0.5, -0.5, 0.5, 0.5, 4, 0, 0), 0, 0, 90, 'device rolled +90 CCW landscape');
});

test('a missing rotation vector returns NaN angles and keeps accuracy and timestamp', () => {
  const missing = probe(['N null 4 2 4242'])[0];
  const [heading, pitch, roll, acc, ts] = nums(missing);
  assert.ok(Number.isNaN(heading) && Number.isNaN(pitch) && Number.isNaN(roll), missing);
  assert.equal(acc, 2);
  assert.equal(ts, 4242);
  const short = probe(['N short 2 1 7'])[0];
  const shortNums = nums(short);
  assert.ok(shortNums.slice(0, 3).every(Number.isNaN), short);
  assert.equal(shortNums[3], 1);
  assert.equal(shortNums[4], 7);
});

test('solar noon elevation and longitude match an independent declination model', () => {
  const ba = { lat: -34.6037, lon: -58.3816 };
  const december = scanSun(ba.lat, ba.lon, Date.UTC(2024, 11, 21, 15, 53), 3 * 3600_000, 120_000);
  const decemberExpected = 90 - Math.abs(ba.lat - cooperDeclinationDeg(december.peak.epochMs));
  near(december.peak.elevation, decemberExpected, 0.7, 'Buenos Aires December noon elevation');
  assert.ok(december.peak.elevation > 78.3 && december.peak.elevation < 79.4, december.peak.elevation);
  assert.ok(azimuthFromNorth(december.peak.azimuth) < 12, `BA Dec azimuth ${december.peak.azimuth}`);
  const decemberNoon = december.peak.epochMs % 86400000 / 60000;
  near(decemberNoon, meanSolarNoonUtcMin(ba.lon), 20, 'Buenos Aires December noon UTC');
  assert.ok(december.rows[0].azimuth > 0 && december.rows[0].azimuth < 180, december.rows[0].azimuth);
  const decemberAfternoon = december.rows[december.rows.length - 1].azimuth;
  assert.ok(decemberAfternoon > 180 && decemberAfternoon < 360, decemberAfternoon);

  const june = scanSun(ba.lat, ba.lon, Date.UTC(2024, 5, 21, 15, 53), 3 * 3600_000, 120_000);
  const juneExpected = 90 - Math.abs(ba.lat - cooperDeclinationDeg(june.peak.epochMs));
  near(june.peak.elevation, juneExpected, 0.7, 'Buenos Aires June noon elevation');
  assert.ok(june.peak.elevation > 31.4 && june.peak.elevation < 32.6, june.peak.elevation);
  assert.ok(azimuthFromNorth(june.peak.azimuth) < 12, `BA June azimuth ${june.peak.azimuth}`);
  near(june.peak.epochMs % 86400000 / 60000, meanSolarNoonUtcMin(ba.lon), 20, 'Buenos Aires June noon UTC');

  const greenwich = scanSun(51.48, 0, Date.UTC(2024, 2, 20, 12, 0), 3 * 3600_000, 120_000);
  const greenwichExpected = 90 - Math.abs(51.48 - cooperDeclinationDeg(greenwich.peak.epochMs));
  near(greenwich.peak.elevation, greenwichExpected, 0.7, 'Greenwich equinox noon elevation');
  assert.ok(greenwich.peak.elevation > 37.8 && greenwich.peak.elevation < 39.3, greenwich.peak.elevation);
  assert.ok(azimuthFrom(greenwich.peak.azimuth, 180) < 8, `Greenwich azimuth ${greenwich.peak.azimuth}`);
  near(greenwich.peak.epochMs % 86400000 / 60000, meanSolarNoonUtcMin(0), 20, 'Greenwich noon UTC');
  assert.ok(greenwich.rows[0].azimuth > 0 && greenwich.rows[0].azimuth < 180, greenwich.rows[0].azimuth);
  const greenwichAfternoon = greenwich.rows[greenwich.rows.length - 1].azimuth;
  assert.ok(greenwichAfternoon > 180 && greenwichAfternoon < 360, greenwichAfternoon);

  const quito = scanSun(-0.1807, -78.4678, Date.UTC(2024, 2, 20, 17, 14), 2 * 3600_000, 120_000);
  assert.ok(quito.peak.elevation > 85, quito.peak.elevation);
  near(quito.peak.epochMs % 86400000 / 60000, meanSolarNoonUtcMin(-78.4678), 25, 'Quito noon UTC');

  const midnightMs = Date.UTC(2024, 11, 21, 3, 54);
  const midnight = nums(probe([`S ${ba.lat} ${ba.lon} ${midnightMs}`])[0]);
  assert.ok(midnight[1] < -20, midnight[1]);
  near(midnight[1], geometricElevationDeg(ba.lat, ba.lon, midnightMs), 1.5, 'Buenos Aires midnight elevation');
});

test('refraction lifts the equinox horizon above the geometric elevation', () => {
  const dayStart = Date.UTC(2024, 2, 20);
  const lines = [];
  for (let minute = 0; minute < 24 * 60; minute += 10) {
    lines.push(`S 51.48 0 ${dayStart + minute * 60_000}`);
  }
  const rows = probe(lines).map((line, index) => {
    const epochMs = dayStart + index * 10 * 60_000;
    return { elevation: nums(line)[1], geometric: geometricElevationDeg(51.48, 0, epochMs) };
  });
  const horizon = rows.reduce((best, row) => (
    Math.abs(row.geometric) < Math.abs(best.geometric) ? row : best
  ));
  assert.ok(Math.abs(horizon.geometric) < 1.3, horizon.geometric);
  const lift = horizon.elevation - horizon.geometric;
  assert.ok(lift > 0.15 && lift < 1.2, `refraction lift ${lift} at geometric ${horizon.geometric}`);
});

test('cardinal labels, spherical separation, and signed azimuth delta', () => {
  const cardinals = probe([
    'C 0', 'C 22.5', 'C 45', 'C 90', 'C 180', 'C 270', 'C 337.5', 'C -45', 'C 360', 'C NaN',
  ]);
  assert.deepEqual(cardinals, ['C N', 'C NE', 'C NE', 'C E', 'C S', 'C W', 'C N', 'C NW', 'C N', 'C N']);
  const labels = probe(['L 12', 'L 12.5', 'L 359.6', 'L NaN']);
  assert.deepEqual(labels, ['L N 12°', 'L N 13°', 'L N 0°', 'L N 0°']);

  const separation = probe([
    'A 0 0 0 0',
    'A 0 0 90 0',
    'A 0 0 0 90',
    'A 0 0 180 0',
    'A 10 20 10 20',
  ]).map((line) => nums(line)[0]);
  near(separation[0], 0, 1e-9, 'same point');
  near(separation[1], 90, 1e-6, 'east of north');
  near(separation[2], 90, 1e-6, 'zenith above north');
  near(separation[3], 180, 1e-6, 'opposite horizon');
  near(separation[4], 0, 1e-9, 'identical look');

  const delta = probe([
    'D 10 20', 'D 10 350', 'D 350 10', 'D 0 180', 'D 10 -170',
  ]).map((line) => nums(line)[0]);
  near(delta[0], 10, 1e-9, 'sun to the right');
  near(delta[1], -20, 1e-9, 'sun across north to the left');
  near(delta[2], 20, 1e-9, 'sun across north to the right');
  near(delta[3], 180, 1e-9, 'opposite stays positive');
  near(delta[4], 180, 1e-9, 'negative opposite wraps positive');
});

test('EV100 follows the exposure formula and the outdoor backlight gate is strict', () => {
  const sunny = nums(probe(['E 10000000 100 16'])[0])[0];
  near(sunny, Math.log2(25600), 1e-9, 'Sunny 16 at 1/100s');
  assert.ok(Math.abs(sunny - 15) > 0.3, sunny);
  const dark = nums(probe(['E 33333333 800 1.8'])[0])[0];
  assert.ok(dark < 8, dark);
  assert.ok(dark > 3, dark);
  const invalid = probe(['E 0 100 16', 'E 10000000 0 16', 'E 10000000 100 0', 'E 10000000 100 NaN', 'E 10000000 100 -2']);
  assert.ok(invalid.every((line) => Number.isNaN(nums(line)[0])), invalid.join(','));

  const constant = nums(probe(['K'])[0])[0];
  assert.equal(constant, 11);
  const gates = probe([
    'B 11 5 45 2',
    'B 10.999 5 45 3',
    'B 11 4.999 45 3',
    'B 11 5 45.001 3',
    'B 11 5 45 1',
    'B NaN 80 0 3',
    'B Infinity 80 0 3',
    'B -Infinity 80 0 3',
    'B 14 40 -10 2',
  ]).map((line) => nums(line)[0]);
  assert.deepEqual(gates, [1, 0, 0, 0, 0, 0, 0, 0, 1]);
});

test('EXIF direction is a normalized hundredths rational', () => {
  const lines = probe(['X 90', 'X 12.345', 'X 359.995', 'X -90', 'X 360', 'X NaN', 'X Infinity', 'X -Infinity']);
  assert.deepEqual(lines, [
    'X 9000/100',
    'X 1235/100',
    'X 0/100',
    'X 27000/100',
    'X 0/100',
    'X null',
    'X null',
    'X null',
  ]);
});
