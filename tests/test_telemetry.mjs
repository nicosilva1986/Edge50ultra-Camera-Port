// SPDX-License-Identifier: MIT
import assert from 'node:assert/strict';
import { execFileSync } from 'node:child_process';
import { mkdirSync, mkdtempSync, readdirSync, readFileSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { delimiter, dirname, join } from 'node:path';
import { after, before, test } from 'node:test';
import { fileURLToPath } from 'node:url';
import { resolveJava } from '../scripts/env_paths.mjs';

const tree = fileURLToPath(new URL('../patches/custom_imaging_java/', import.meta.url));
const java = resolveJava();
const javac = join(dirname(java), process.platform === 'win32' ? 'javac.exe' : 'javac');
let work;
function fixture(name, content) {
  const path = join(work, 'fixture', name);
  mkdirSync(dirname(path), { recursive: true });
  writeFileSync(path, content);
  return path;
}

const fields = {
  Long: ['SENSOR_TIMESTAMP', 'SENSOR_EXPOSURE_TIME', 'SENSOR_FRAME_DURATION', 'SENSOR_ROLLING_SHUTTER_SKEW'],
  Integer: ['SENSOR_SENSITIVITY', 'CONTROL_AF_STATE', 'CONTROL_AE_STATE', 'CONTROL_AWB_STATE', 'STATISTICS_SCENE_FLICKER'],
  Float: ['LENS_FOCAL_LENGTH', 'LENS_APERTURE', 'LENS_FOCUS_DISTANCE'],
  RggbChannelVector: ['COLOR_CORRECTION_GAINS'],
  ColorSpaceTransform: ['COLOR_CORRECTION_TRANSFORM'],
};

function compileProbe() {
  work = mkdtempSync(join(tmpdir(), 'telemetry-test-'));
  const classes = join(work, 'classes');
  mkdirSync(classes);
  const declarations = Object.entries(fields).flatMap(([type, names]) =>
    names.map(name => 'public static final Key<' + type + '> ' + name + ' = new Key<>();')).join('\n');
  // Supply the public SDK fields missing from the partial production compile stubs.
  const files = [
    fixture('android/content/Context.java', `package android.content;
      public class Context {
        public Object getSystemService(String name) { return null; }
        public int checkSelfPermission(String perm) { return -1; }
      }`),
    fixture('android/hardware/camera2/CaptureResult.java', `package android.hardware.camera2;
      import android.hardware.camera2.params.*;
      import java.util.*;
      public class CaptureResult {
        public static final class Key<T> {}` + declarations + `
        private final Map<Key<?>, Object> tags = new HashMap<>();
        public <T> void put(Key<T> key, T value) { tags.put(key, value); }
        @SuppressWarnings("unchecked") public <T> T get(Key<T> key) {
          if (key == LENS_APERTURE && !tags.containsKey(key)) throw new IllegalArgumentException("unavailable");
          return (T) tags.get(key);
        }
      }`),
    fixture('android/hardware/camera2/params/RggbChannelVector.java', `package android.hardware.camera2.params;
      public class RggbChannelVector {
        public float getRed(){return 2;} public float getGreenEven(){return 1;}
        public float getGreenOdd(){return 1.25f;} public float getBlue(){return 3;}
      }`),
    fixture('android/util/Rational.java', `package android.util;
      public class Rational { private final float f; public Rational(float f){this.f=f;} public float floatValue(){return f;} }`),
    fixture('android/hardware/camera2/params/ColorSpaceTransform.java', `package android.hardware.camera2.params;
      public class ColorSpaceTransform {
        public void copyElements(android.util.Rational[] a,int offset) {
          for(int i=0;i<9;i++) a[offset+i]=new android.util.Rational(i-4);
        }
      }`),
    fixture('android/hardware/Samples.java', `package android.hardware;
      public class Samples {
        public static void emit(SensorEventListener l, Sensor sensor, long time, float... values) {
          emitAcc(l, sensor, time, 0, values);
        }
        public static void emitAcc(SensorEventListener l, Sensor sensor, long time, int acc, float... values) {
          SensorEvent e=new SensorEvent(values.length); e.sensor=sensor; e.timestamp=time; e.accuracy=acc;
          System.arraycopy(values,0,e.values,0,values.length); l.onSensorChanged(e);
          java.util.Arrays.fill(e.values,9999);
        }
      }`),
    fixture('com/motorola/camera/custom/TelemetryProbe.java', probe),
    join(tree, 'src/com/motorola/camera/custom/CompassSolarHelper.java'),
    join(tree, 'src/com/motorola/camera/custom/TelemetryCollector.java'),
  ];
  execFileSync(javac, ['--release', '11', '-sourcepath',
    [join(work, 'fixture'), join(tree, 'stubs')].join(delimiter), '-d', classes, ...files],
  { windowsHide: true });
}
after(() => { if (work) rmSync(work, { recursive: true, force: true }); });

function run(op, ...args) {
  const output = execFileSync(java, ['-cp', join(work, 'classes'), 'com.motorola.camera.custom.TelemetryProbe', op, ...args],
    { encoding: 'utf8', windowsHide: true, timeout: 15000 });
  return output.trim().split(/\r?\n/).map(s => JSON.parse(s));
}

const probe = String.raw`package com.motorola.camera.custom;
import android.content.Context;
import android.hardware.*;
import android.hardware.camera2.*;
import android.hardware.camera2.params.*;
import android.os.Handler;
import java.io.*;
import java.nio.file.*;
import java.util.*;
import static android.hardware.camera2.CaptureResult.*;
import static com.motorola.camera.custom.TelemetryCollector.*;

public class TelemetryProbe {
  static final long T = 9007199254740993L, MS = 1000000;
  static final double[] XYZ = {1,0,0,0,1,0,0,0,1};
  static final class Device extends Sensor {
    final int type; final String name, id;
    Device(int t, String n, String s) {type=t; name=n; id=s;}
    public int getType(){return type;} public String getName(){return name;} public String getStringType(){return id;}
  }
  static final class Manager extends SensorManager {
    final Sensor gyro=new Device(4,"icm","gyro"), acc=new Device(1,"icm","acc");
    final Sensor rgb=new Device(45,"TCS3408 ALTERNATE RGB","vendor.alternate_rgb");
    final Sensor light=new Device(5,"tcs3408 rear","android.sensor.light");
    final Sensor tof=new Device(52,"Rear Proximity","com.motorola.sensor.tof");
    SensorEventListener listener; int registered, unregistered, fastAttempts;
    public Sensor getDefaultSensor(int n){return n==4 ? gyro : acc;}
    public List<Sensor> getSensorList(int n){return Arrays.asList(new Device(5,"Front light","android.sensor.light"),rgb,light,tof);}
    public boolean registerListener(SensorEventListener l,Sensor s,int period,Handler h){
      if(s==gyro && period==2500){fastAttempts++;throw new SecurityException("rate cap");}
      if(s==acc && period==2500){fastAttempts++;return false;}
      listener=l;registered++;return true;
    }
    public void unregisterListener(SensorEventListener l){if(l==listener)unregistered++;}
    void send(Sensor s,long t,float... values){Samples.emit(listener,s,t,values);}
  }
  public static final class Host extends Context {
    final Manager manager=new Manager();
    public Object getSystemService(String name){return "sensor".equals(name) ? manager : null;}
  }
  static TotalCaptureResult frame(long t,long exposure){
    TotalCaptureResult r=new TotalCaptureResult();
    r.put(SENSOR_TIMESTAMP,t); r.put(SENSOR_EXPOSURE_TIME,exposure); r.put(SENSOR_FRAME_DURATION,33*MS);
    r.put(SENSOR_ROLLING_SHUTTER_SKEW,5*MS);r.put(SENSOR_SENSITIVITY,320);
    r.put(LENS_FOCAL_LENGTH,6.57f);r.put(LENS_APERTURE,1.6f);r.put(LENS_FOCUS_DISTANCE,0f);
    r.put(CONTROL_AF_STATE,4);r.put(CONTROL_AE_STATE,2);r.put(CONTROL_AWB_STATE,2);r.put(STATISTICS_SCENE_FLICKER,2);
    r.put(COLOR_CORRECTION_GAINS,new RggbChannelVector());r.put(COLOR_CORRECTION_TRANSFORM,new ColorSpaceTransform());
    return r;
  }
  static void print(TotalCaptureResult r,ShotMetadata m){
    System.out.println(buildShotTelemetryJson(r,m,"rawBurst",6,2,8));
  }
  static SpectralLayout layout(){return new SpectralLayout(2,3,0,1,4,5,XYZ);}
  static void capture() {
    Host h=new Host(); Manager m=h.manager;
    onCameraActive(h,"4",false,layout());
    try {
      ShotMetadata shot=shotMetadata("s\n\"id",23.5f,true);
      m.send(m.rgb,T-MS,108.883f,110,95.047f,100,77,120);
      m.send(m.light,T-MS,240);m.send(m.tof,T-MS,7);
      for(int i=0;i<5;i++){
        m.send(m.gyro,T+i*2500000L,0,3,4);
        m.send(m.acc,T+i*2500000L,0,0,9.8f);
      }
      m.send(m.gyro,T+5*MS,100,100,100);
      m.send(m.gyro,T+11*MS,Float.NaN,0,0);
      m.send(m.light,T+20*MS,1000);
      TotalCaptureResult r=frame(T,10*MS);
      print(r,shot);
      print(frame(T+MS,8*MS),shot);
      print(r,shotMetadata("unknown",null,false));
      System.out.println(escapeJson(buildConciseExifNote(r,shot,"rawBurst",6,2,8)));
      onCameraPaused();
      m.send(m.gyro,T+12*MS,10,10,10);
      onCameraActive(h,"1",true);
      print(r,shot);
      print(r,shotMetadata(null,null,true));
      System.out.println("["+m.fastAttempts+","+m.registered+","+m.unregistered+"]");
    } finally {onCameraPaused();}
  }
  static void failures(){
    Host h=new Host();Manager m=h.manager;
    onCameraActive(h,"0",false);
    try {
      ShotMetadata shot=shotMetadata(null,Float.NaN,true);
      m.send(m.rgb,T,1,2,3,4,5,6);m.send(m.gyro,T,0,0,0);m.send(m.gyro,T+40*MS,1,0,0);
      print(frame(T,40*MS),shot);
      print(frame(T+2000*MS,MS),shot);
      print(new TotalCaptureResult(),shot);
      for(int i=0;i<8250;i++)m.send(m.gyro,T+(50L+i)*MS,0,1,0);
      print(frame(T,MS),shot);
      print(frame(T+8297*MS,MS),shot);
    } finally {onCameraPaused();}
    onCameraActive(h,"3",false,layout());
    try {
      ShotMetadata shot=shotMetadata(null,null,true);
      int i=0;
      for(float f:new float[]{50,60,100,120,83}){
        long time=T+(++i)*MS;
        m.send(m.rgb,time,100,99,100,100,Float.NaN,f);
        print(frame(time,MS),shot);
      }
      long time=T+10*MS;m.send(m.rgb,time,1,2);print(frame(time,MS),shot);
    } finally {onCameraPaused();}
  }
  static void helpers(){
    System.out.println(escapeJson(null));
    System.out.println(escapeJson("a\b\f\n\r\t\\\"\u0001\ud83d\udcf7\ud800"));
    for(double raw:new double[]{37500,-1200,500,0,151000,-41000,Double.NaN,Double.POSITIVE_INFINITY})
      System.out.println(normalizeThermalCelsius(raw,true));
    System.out.println(normalizeThermalCelsius(36.5,false));
    System.out.println(normalizeThermalCelsius(800,false));
    for(double[] rgb:new double[][]{{95.047,100,108.883},{0,1,1},{1,-1,1},{1,1,0},{1,1,Double.NaN},{1,1,Double.POSITIVE_INFINITY}})
      System.out.println(estimateCctKelvin(rgb[0],rgb[1],rgb[2],XYZ));
    System.out.println(estimateCctKelvin(1,1,1,null));
    System.out.println(estimateCctKelvin(1,1,1,new double[8]));
    System.out.println(estimateCctKelvin(.3,.1858,.5142,XYZ));
    System.out.println(estimateCctKelvin(.72,.20,.08,XYZ));
    long[] t={0,10000000,20000000};
    System.out.println(gyroExcursionRad(t,new float[][]{{0,2,0},{0,0,0},{0,-2,0}}));
    System.out.println(gyroExcursionRad(t,new float[][]{{0,0,0},{0,0,0},{0,0,0}}));
    float halfPi=(float)(Math.PI/2);
    System.out.println(gyroExcursionRad(new long[]{0,1000000000L,2000000000L,3000000000L,4000000000L},
      new float[][]{{0,0,0},{halfPi,0,0},{0,0,0},{0,halfPi,0},{0,0,0}}));
    for(long[] bad:new long[][]{null,{0},{0,0},{2,1},{-1,1},{0,1,2}})
      System.out.println(gyroExcursionRad(bad,new float[][]{{0,0,1},{0,0,1}}));
    System.out.println(gyroExcursionRad(new long[]{0,1},new float[][]{null,{1,1,1}}));
    System.out.println(gyroExcursionRad(new long[]{0,1},new float[][]{{0,0,0},{Float.NaN,0,0}}));
    try {new SpectralLayout(0,0,1,2,3,4,XYZ);throw new AssertionError();}catch(IllegalArgumentException expected){}
    try {new SpectralLayout(16,0,1,2,3,4,XYZ);throw new AssertionError();}catch(IllegalArgumentException expected){}
    try {new SpectralLayout(0,1,2,3,4,5,new double[5]);throw new AssertionError();}catch(IllegalArgumentException expected){}
    try {buildShotTelemetryJson(null,null,"HDR+",1,1,1);throw new AssertionError();}catch(IllegalArgumentException expected){}
  }
  public static void main(String[] args)throws Exception{
    switch(args[0]){
      case "capture":capture();break;
      case "failures":failures();break;
      case "helpers":helpers();break;
      case "invalid":
        TotalCaptureResult invalid=frame(T,-1);
        invalid.put(LENS_FOCAL_LENGTH,Float.NaN);invalid.put(LENS_APERTURE,Float.POSITIVE_INFINITY);
        invalid.put(SENSOR_SENSITIVITY,0);
        print(invalid,null);
        break;
      case "empty":
        for(String mode:new String[]{"vendor","singleRaw","rawBurst"})
          System.out.println(buildShotTelemetryJson(null,null,mode,6,0,8));
        break;
      case "thermal":
        for(float f:TelemetryCollector.readThermalZones(Paths.get(args[1])))
          System.out.println(Float.isFinite(f)?Float.toString(f):"null");
        break;
      case "sidecar":
        File dst=new File(args[1]);
        System.out.println(writeSidecarJsonIfEnabled(null,"{}"));
        System.out.println(writeSidecarJsonIfEnabled(dst,null));
        System.out.println(writeSidecarJsonIfEnabled(dst,"{\"first\":true}"));
        java.util.concurrent.ExecutorService pool=java.util.concurrent.Executors.newFixedThreadPool(2);
        try {
          List<java.util.concurrent.Future<Boolean>> results=new ArrayList<>();
          for(int i=0;i<16;i++){
            final String json="{\"writer\":"+i+"}";
            results.add(pool.submit(()->writeSidecarJsonIfEnabled(dst,json)));
          }
          for(java.util.concurrent.Future<Boolean> result:results) if(!result.get()) throw new AssertionError();
          System.out.println(Files.readString(dst.toPath()));
        } finally {pool.shutdownNow();}
        System.out.println(writeSidecarJsonIfEnabled(dst,"{\"replacement\":true}"));
        System.out.println(writeSidecarJsonIfEnabled(dst,"{\"replacement\":true}"));
        System.out.println(writeSidecarJsonIfEnabled(dst.getParentFile(),"{}"));
        System.out.println(writeSidecarJsonIfEnabled(new File(dst,"bad"),"{}"));
        break;
      case "compass":
        final Sensor rv = new Device(11, "qti-rv", "android.sensor.rotation_vector");
        class CompassManager extends SensorManager {
          SensorEventListener rvListener;
          public Sensor getDefaultSensor(int n) { return n == 11 ? rv : null; }
          public boolean registerListener(SensorEventListener l, Sensor s, int p, Handler h) {
            if (s == rv) { rvListener = l; return true; }
            return false;
          }
          public void unregisterListener(SensorEventListener l) {}
          void emit(long t, int acc, float... v) { Samples.emitAcc(rvListener, rv, t, acc, v); }
        }
        CompassManager compassMgr = new CompassManager();
        final android.location.Location fixedLoc = new android.location.Location("gps") {
          public double getLatitude() { return -34.6037; }
          public double getLongitude() { return -58.3816; }
          public long getTime() { return System.currentTimeMillis() - 60_000L; }
        };
        final android.location.LocationManager locMgr = new android.location.LocationManager() {
          public android.location.Location getLastKnownLocation(String p) { return "gps".equals(p) ? fixedLoc : null; }
        };
        Context compassCtx = new Context() {
          public int checkSelfPermission(String perm) { return 0; }
          public Object getSystemService(String name) {
            if ("sensor".equals(name)) return compassMgr;
            if ("location".equals(name)) return locMgr;
            return null;
          }
        };
        onCameraActive(compassCtx, "0", false);
        try {
          ShotMetadata sm = shotMetadata("comp1", 10f, true);
          float s2 = (float) Math.sqrt(0.5);
          // Upright portrait facing North (Rx(+90)): [s2, 0, 0, s2]
          compassMgr.emit(T - MS, 3, s2, 0f, 0f, s2);
          TotalCaptureResult cr = frame(T, 1_000_000L);
          cr.put(SENSOR_SENSITIVITY, 100);
          cr.put(LENS_APERTURE, 2.0f);
          System.out.println(buildShotTelemetryJson(cr, sm, "vendor", 0, 0, 0));
          // Low calibration should fail outdoor backlit gate even at bright EV100
          compassMgr.emit(T + 5 * MS, 1, s2, 0f, 0f, s2);
          System.out.println(buildShotTelemetryJson(frame(T + 6 * MS, 1_000_000L), sm, "vendor", 0, 0, 0));
        } finally { onCameraPaused(); }
        break;
      default:throw new AssertionError(args[0]);
    }
  }
}`;

before(compileProbe);

test('schema v1 preserves unknown measurements and absent ctwo hardware for every capture method', () => {
  const shots = run('empty');
  assert.deepEqual(shots.map(s => s.captureMethod), ['vendor', 'singleRaw', 'rawBurst']);
  for (const s of shots) {
    assert.equal(s.schemaVersion, 1);
    assert.equal(s.cameraId, null);
    assert.equal(s.isFront, null);
    assert.equal(s.iqLuxIdx, null);
    assert.deepEqual(Object.keys(s.captureResult).sort(), Object.values(fields).flat().sort());
    assert.ok(Object.values(s.captureResult).every(v => v === null));
    for (const k of ['humidityPct', 'pressureHpa', 'ambientTempC']) {
      assert.equal(s[k], null);
      assert.equal(s.unavailableReasons[k], 'notPresentOnHardware');
    }
    for (const zone of ['camera-0', 'camera-1', 'cam-therm', 'msm-therm', 'mmi_battery']) {
      assert.equal(s.thermalC[zone], null);
      assert.ok(s.thermalC.reasons[zone]);
    }
  }
});

test('invalid numeric metadata is unknown while zero diopters remains a valid focus distance', () => {
  const [s] = run('invalid');
  for (const key of ['SENSOR_EXPOSURE_TIME', 'LENS_FOCAL_LENGTH', 'LENS_APERTURE', 'SENSOR_SENSITIVITY']) {
    assert.equal(s.captureResult[key], null);
  }
  assert.equal(s.captureResult.LENS_FOCUS_DISTANCE, 0);
});

test('matches frame time, preserves Camera2 precision, and isolates old sessions on a camera switch', () => {
  const [s, clipped, unknown, note, old, fresh, calls] = run('capture');
  assert.deepEqual(s.captureResult, {
    SENSOR_TIMESTAMP: '9007199254740993', SENSOR_EXPOSURE_TIME: '10000000', SENSOR_FRAME_DURATION: '33000000',
    SENSOR_SENSITIVITY: 320, SENSOR_ROLLING_SHUTTER_SKEW: '5000000', LENS_FOCAL_LENGTH: 6.57,
    LENS_APERTURE: 1.6, LENS_FOCUS_DISTANCE: 0, CONTROL_AF_STATE: 4, CONTROL_AE_STATE: 2,
    CONTROL_AWB_STATE: 2, STATISTICS_SCENE_FLICKER: 2, COLOR_CORRECTION_GAINS: [2, 1, 1.25, 3],
    COLOR_CORRECTION_TRANSFORM: [-4,-3,-2,-1,0,1,2,3,4],
  });
  assert.deepEqual([s.shotId, s.cameraId, s.isFront, s.lookId, s.bokehId, s.profileId], ['s\n"id', '4', false, 6, 2, 8]);
  assert.equal(s.cameraSceneMainsClassHz, 60);
  const { angularExcursionRad, ...stats } = s.gyro;
  assert.deepEqual(stats, { sampleCount: 5, achievedHz: 400, rmsRadPerSec: 5, peakRadPerSec: 5, reason: null });
  assert.ok(Math.abs(angularExcursionRad - 0.05) < 1e-12);
  assert.ok(Math.abs(s.accelerometer.rmsMps2 - 9.8) < 0.00001);
  assert.equal(clipped.gyro.sampleCount, 3);
  assert.ok(Math.abs(clipped.gyro.angularExcursionRad - 0.04) < 1e-12);
  assert.equal(s.iqLuxIdx, 23.5);
  assert.equal(s.rearAls.lux, 240);
  assert.deepEqual(s.rearTof.raw, [7]);
  assert.equal(s.rearTof.distanceMm, null);
  assert.deepEqual([s.rearSpectral.redCounts, s.rearSpectral.greenCounts, s.rearSpectral.blueCounts,
    s.rearSpectral.clearCounts, s.rearSpectral.widebandCounts], [95.047, 100, 108.883, 110, 77]);
  assert.ok(Math.abs(s.rearSpectral.cctK - 6504) < 15); // CIE D65, independent reference.
  assert.match(note, /capture=rawBurst look=6 bokeh=2 profile=8/);
  assert.match(note, /ISO=320/);
  assert.ok(note.length < 160);
  assert.equal(unknown.gyro.reason, 'clockUnverified');
  assert.equal(unknown.rearSpectral.raw, null);
  assert.equal(old.gyro.reason, 'sessionUnavailable');
  assert.equal(old.cameraId, '4');
  assert.equal(fresh.cameraId, '1');
  assert.equal(fresh.isFront, true);
  assert.equal(fresh.gyro.angularExcursionRad, null);
  assert.deepEqual(calls, [4, 10, 1]); // Both sessions recovered from the 400 Hz registration failures.
});

test('rejects stale, unmapped, truncated and incomplete evidence, including overwritten ring slots', () => {
  const [gap, stale, missing, overwritten, recent, ...spectra] = run('failures');
  assert.equal(gap.gyro.reason, 'sampleGap');
  assert.equal(gap.gyro.rmsRadPerSec, null);
  assert.equal(gap.iqLuxIdx, null);
  assert.deepEqual(gap.rearSpectral.raw, [1, 2, 3, 4, 5, 6]);
  assert.equal(gap.rearSpectral.reason, 'unverifiedLayout');
  assert.equal(gap.rearSpectral.redCounts, null);
  assert.equal(stale.rearSpectral.reason, 'stale');
  assert.equal(stale.rearSpectral.raw, null);
  assert.equal(missing.gyro.reason, 'missingTimestamp');
  assert.equal(missing.captureResult.LENS_APERTURE, null); // Framework getter threw.
  assert.equal(overwritten.gyro.angularExcursionRad, null);
  assert.ok(Math.abs(recent.gyro.angularExcursionRad - 0.001) < 1e-12);
  assert.deepEqual(spectra.map(s => [s.rearSpectral.mainsClassHz, s.rearSpectral.nominalOpticalHz,
    s.rearSpectral.opticalFlickerHz]), [[50,100,null], [60,120,null], [50,100,100], [60,120,120],
    [null,null,null], [null,null,null]]);
  assert.equal(spectra[0].rearSpectral.widebandCounts, null);
  assert.equal(spectra.at(-1).rearSpectral.cctK, null);
});

test('pure helpers preserve escaped Unicode, physical temperature units and angular reversals', () => {
  const [literalNull, escaped, ...v] = run('helpers');
  assert.equal(literalNull, null);
  assert.equal(escaped, 'a\b\f\n\r\t\\"\u0001📷\ud800');
  assert.deepEqual(v.splice(0, 10), [37.5,-1.2,0.5,0,null,null,null,null,36.5,null]);
  assert.ok(Math.abs(v.shift() - 6504) < 15);
  assert.deepEqual(v.splice(0, 9), Array(9).fill(null));
  assert.ok(Math.abs(v.shift() - 0.01) < 1e-12);
  assert.equal(v.shift(), 0);
  // Successive right angles about perpendicular body axes compose to a 120 degree rotation.
  assert.ok(Math.abs(v.shift() - 2*Math.PI/3) < 1e-6);
  assert.deepEqual(v, Array(8).fill(null));
});

test('thermal readings follow kernel type names across zone renumbering and reject bad readings', () => {
  const root = join(work, 'sys');
  for (const [id, type, value] of [
    [75,'camera-0','39500'],[4,'camera-1','-1200'],[37,'other','22000'],
    [2,'msm-therm','error'],[55,'cam-therm','300001'],[90,'mmi_battery','501'],
  ]) {
    const dir = join(root, 'thermal_zone' + id);
    mkdirSync(dir, { recursive: true });
    writeFileSync(join(dir,'type'), type + '\n');
    writeFileSync(join(dir,'temp'), value + '\n');
  }
  assert.deepEqual(run('thermal', root), [39.5,-1.2,null,null,0.501]);
  assert.deepEqual(run('thermal', join(root, 'missing')), [null,null,null,null,null]);
});

test('sidecar retries replace one complete UTF-8 file and clean up failed writes', () => {
  const dir = join(work, 'shots');
  mkdirSync(dir);
  const dst = join(dir, 'sample.json');
  const results = run('sidecar', dst);
  const [{ writer }] = results.splice(3, 1);
  assert.ok(Number.isInteger(writer) && writer >= 0 && writer < 16);
  assert.deepEqual(results, [false,false,true,true,true,false,false]);
  assert.deepEqual(JSON.parse(readFileSync(dst, 'utf8')), { replacement: true });
  assert.deepEqual(readdirSync(dir), ['sample.json']);
});

test('compass telemetry records ENU heading, solar ephemeris and strict EV100/accuracy status', () => {
  const [calibrated, uncal] = run('compass');
  assert.equal(calibrated.compass.status, 'ok');
  assert.equal(calibrated.compass.accuracy, 3);
  assert.equal(calibrated.compass.cardinal, 'N');
  assert.ok(Math.abs(calibrated.compass.headingDeg) < 0.1);
  assert.ok(Math.abs(calibrated.compass.pitchDeg) < 0.1);
  assert.ok(calibrated.compass.ev100 > 11.0);
  assert.ok(Number.isFinite(calibrated.compass.sunAzimuthDeg));
  assert.ok(Number.isFinite(calibrated.compass.sunElevationDeg));
  assert.equal(uncal.compass.status, 'uncalibrated');
  assert.equal(uncal.compass.physicalOutdoorBacklit, false);
});
