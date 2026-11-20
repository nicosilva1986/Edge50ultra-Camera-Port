/**
 * Deterministic extractor for MotCamera4_v3 developer-menu keys,
 * DebugBroadcastHelper actions, and ctwo app/IQ/MCF tunables.
 * Node.js ESM built-ins only.
 */
import { readFileSync, writeFileSync, mkdirSync } from 'node:fs';
import { dirname, join, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

import { resolveBaseDir } from './env_paths.mjs';

const SCRIPT_DIR = dirname(fileURLToPath(import.meta.url));
export const MOD_ROOT = resolve(SCRIPT_DIR, '..');
export const RE_ROOT = resolveBaseDir();
export const DECOMPILED = join(RE_ROOT, 'decompiled', 'MotCamera4_v3');
export const JSON_OUT = join(MOD_ROOT, 'docs', 'TUNABLE_KEYS_REFERENCE.json');
export const MD_OUT = join(MOD_ROOT, 'docs', 'CAMERA_MOD_FEATURES.md');

const EXPLICIT_APP_FIELDS = ['PREVIEW_SIZE', 'ACTIVITY_TIMEOUT', 'COMPOSITION_GUIDE'];
const TAB_ORDER = ['app', 'mcf_algorithm', 'iq'];

export function tabsForName(name, explicitNames) {
  const tabs = [];
  if (name.includes('.debug_') || name.includes('dump_') || explicitNames.has(name)) tabs.push('app');
  if (name.includes('mcf_debug_') || name.includes('ai_debug_')) tabs.push('mcf_algorithm');
  if (name.includes('tuning_debug_')) tabs.push('iq');
  return tabs;
}

export function unescapeSmali(value) {
  let out = '';
  for (let i = 0; i < value.length; i += 1) {
    if (value[i] !== '\\') {
      out += value[i];
      continue;
    }
    const next = value[i + 1];
    if (next === 'n') out += '\n';
    else if (next === 't') out += '\t';
    else if (next === 'r') out += '\r';
    else if (next === '"' || next === '\\' || next === "'") out += next;
    else if (next === 'u') {
      out += String.fromCharCode(Number.parseInt(value.slice(i + 2, i + 6), 16));
      i += 4;
    } else out += next ?? '';
    i += 1;
  }
  return out;
}

function unescapeXml(value) {
  return value
    .replace(/&#x([0-9a-fA-F]+);/g, (_, hex) => String.fromCodePoint(Number.parseInt(hex, 16)))
    .replace(/&#(\d+);/g, (_, dec) => String.fromCodePoint(Number(dec)))
    .replace(/&quot;/g, '"')
    .replace(/&apos;/g, "'")
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&amp;/g, '&')
    .replace(/\\n/g, '\n')
    .replace(/\\'/g, "'")
    .replace(/\\"/g, '"');
}

function androidStringValue(raw) {
  const trimmed = raw.trim();
  const unescaped = unescapeXml(trimmed);
  if (unescaped.length >= 2 && unescaped.startsWith('"') && unescaped.endsWith('"')) {
    return unescaped.slice(1, -1);
  }
  return unescaped;
}

function linesOf(text) {
  return text.split(/\r?\n/);
}

function lineOf(text, needle) {
  const lines = linesOf(text);
  const index = lines.findIndex((line) => line.includes(needle));
  if (index < 0) throw new Error(`Missing source text: ${needle}`);
  return index + 1;
}

function methodBody(text, signature) {
  const start = text.indexOf(signature);
  if (start < 0) throw new Error(`Missing method ${signature}`);
  const signatureLine = text.slice(0, start).split('\n').length;
  const from = text.indexOf('\n', start) + 1;
  const next = text.indexOf('\n.method ', from);
  return {
    text: text.slice(from, next < 0 ? text.length : next),
    startLine: signatureLine + 1,
  };
}

function descriptorToType(descriptor, primitiveType) {
  let arrayDepth = 0;
  let rest = descriptor;
  while (rest.startsWith('[')) {
    arrayDepth += 1;
    rest = rest.slice(1);
  }
  let name = rest;
  if (rest.startsWith('L') && rest.endsWith(';')) name = rest.slice(1, -1).replaceAll('/', '.');
  if (primitiveType) {
    const primitive = {
      'java.lang.Boolean': 'boolean',
      'java.lang.Integer': 'int',
      'java.lang.Long': 'long',
      'java.lang.Float': 'float',
      'java.lang.Double': 'double',
      'java.lang.Byte': 'byte',
      'java.lang.Short': 'short',
      'java.lang.Character': 'char',
    };
    name = primitive[name] ?? name;
  }
  return name + '[]'.repeat(arrayDepth);
}

function controlForType(type) {
  const table = {
    boolean: [0, 'switch'],
    'java.lang.Boolean': [0, 'switch'],
    int: [1, 'integer_dialog'],
    'java.lang.Integer': [1, 'integer_dialog'],
    long: [1, 'integer_dialog'],
    'java.lang.Long': [1, 'integer_dialog'],
    float: [2, 'float_dialog'],
    'java.lang.Float': [2, 'float_dialog'],
    double: [2, 'float_dialog'],
    'java.lang.Double': [2, 'float_dialog'],
    'java.lang.String': [3, 'string_dialog'],
    'android.util.Size': [4, 'size_dialog'],
    'android.graphics.Rect': [5, 'rect_dialog'],
    'android.graphics.Point': [6, 'point_dialog'],
    'android.util.Range': [7, 'range_dialog'],
    'com.motorola.camera.VideoFormat': [8, 'video_format_dialog'],
    'java.lang.String[]': [9, 'string_array_dialog'],
  };
  if (table[type]) {
    const [viewType, control] = table[type];
    return { view_type: viewType, control };
  }
  return {
    view_type: null,
    control: 'dialog_or_enum',
    view_type_note: 'SettingsManagerFragment.getKeyViewType returns 10 when mType.isEnum() and 11 otherwise',
  };
}

function loadStrings(decompiled) {
  const publicXml = readFileSync(join(decompiled, 'res', 'values', 'public.xml'), 'utf8');
  const stringsXml = readFileSync(join(decompiled, 'res', 'values', 'strings.xml'), 'utf8');
  const idToName = new Map();
  for (const match of publicXml.matchAll(/<public type="string" name="([^"]+)" id="(0x[0-9a-fA-F]+)" \/>/g)) {
    idToName.set(Number.parseInt(match[2], 16), match[1]);
  }
  const nameToValue = new Map();
  for (const match of stringsXml.matchAll(/<string name="([^"]+)">([\s\S]*?)<\/string>/g)) {
    nameToValue.set(match[1], androidStringValue(match[2]));
  }
  const byId = new Map();
  for (const [id, name] of idToName) {
    byId.set(id, { name, value: nameToValue.get(name) ?? null });
  }
  return { byId, nameToValue, publicXml };
}

function parseConstString(line) {
  const match = line.match(/^\s*const-string(?:\/jumbo)?\s+(\w+),\s+"(.*)"\s*$/);
  if (!match) return null;
  return { register: match[1], value: unescapeSmali(match[2]) };
}

function parseConstInt(line) {
  const match = line.match(/^\s*const(?:\/16|\/high16)?\s+(\w+),\s+(-?0x[0-9a-fA-F]+|-?\d+)\s*$/);
  if (!match) return null;
  return { register: match[1], value: Number.parseInt(match[2], match[2].includes('0x') ? 16 : 10) };
}

export function parseClinitKeys(clinitText, stringsById, startLine = 1) {
  const registers = new Map();
  const pending = new Map();
  const keys = [];
  const lines = linesOf(clinitText);
  lines.forEach((line, index) => {
    const lineNo = startLine + index;
    const move = line.match(/^\s*move-object(?:\/from16|\/16)?\s+(\w+),\s+(\w+)\s*$/);
    if (move) {
      if (registers.has(move[2])) registers.set(move[1], registers.get(move[2]));
      else registers.delete(move[1]);
      return;
    }
    const str = parseConstString(line);
    if (str) {
      registers.set(str.register, { kind: 'string', value: str.value });
      return;
    }
    const integer = parseConstInt(line);
    if (integer) {
      registers.set(integer.register, { kind: 'int', value: integer.value });
      return;
    }
    const primitive = line.match(/^\s*sget-object\s+(\w+),\s+(L[^;]+;)->TYPE:Ljava\/lang\/Class;\s*$/);
    if (primitive) {
      registers.set(primitive[1], { kind: 'type', descriptor: primitive[2], primitive: true });
      return;
    }
    const constClass = line.match(/^\s*const-class\s+(\w+),\s+(\[*(?:L[^;]+;|[ZBSCIJFD]))\s*$/);
    if (constClass) {
      registers.set(constClass[1], { kind: 'type', descriptor: constClass[2], primitive: false });
      return;
    }
    const init = line.match(/^\s*invoke-direct\s+\{([^}]+)\},\s+Lcom\/motorola\/camera\/settings\/SettingsManager\$Key;-><init>\(([^)]+)\)V\s*$/);
    if (init) {
      const args = init[1].split(',').map((part) => part.trim());
      const [instance, nameReg, typeReg] = args;
      const nameSlot = registers.get(nameReg);
      const typeSlot = registers.get(typeReg);
      if (!nameSlot || !typeSlot || typeSlot.kind !== 'type') {
        throw new Error(`Unresolved Key.<init> at clinit line ${lineNo}`);
      }
      let name;
      let nameSource;
      let resourceId = null;
      let resourceName = null;
      if (init[2].startsWith('Ljava/lang/String;')) {
        if (nameSlot.kind !== 'string') throw new Error(`Key name register is not a string at line ${lineNo}`);
        name = nameSlot.value;
        nameSource = 'literal';
      } else if (init[2].startsWith('I')) {
        if (nameSlot.kind !== 'int') throw new Error(`Key name register is not an int at line ${lineNo}`);
        const resolved = stringsById.get(nameSlot.value);
        if (!resolved || resolved.value == null) {
          throw new Error(`Unresolved string resource 0x${nameSlot.value.toString(16)} at line ${lineNo}`);
        }
        name = resolved.value;
        nameSource = 'string_resource';
        resourceId = `0x${nameSlot.value.toString(16)}`;
        resourceName = resolved.name;
      } else {
        throw new Error(`Unexpected Key.<init> signature ${init[2]} at line ${lineNo}`);
      }
      pending.set(instance, {
        name,
        name_source: nameSource,
        resource_id: resourceId,
        resource_name: resourceName,
        type: descriptorToType(typeSlot.descriptor, typeSlot.primitive),
        init_line: lineNo,
      });
      return;
    }
    const stored = line.match(/^\s*sput-object\s+(\w+),\s+Lcom\/motorola\/camera\/settings\/SettingsManager;->(\w+):Lcom\/motorola\/camera\/settings\/SettingsManager\$Key;\s*$/);
    if (stored) {
      const built = pending.get(stored[1]);
      if (!built) throw new Error(`sput-object ${stored[2]} has no pending Key at line ${lineNo}`);
      keys.push({ field: stored[2], line: lineNo, ...built });
      pending.delete(stored[1]);
    }
  });
  return keys;
}

function expandRegisters(blob) {
  const range = blob.match(/^(\w+)\s+\.\.\s+(\w+)$/);
  if (!range) return blob.split(',').map((part) => part.trim());
  const start = Number(range[1].slice(1));
  const end = Number(range[2].slice(1));
  const prefix = range[1][0];
  const regs = [];
  for (let i = start; i <= end; i += 1) regs.push(`${prefix}${i}`);
  return regs;
}

export function parseFactoryKeyFields(methodText) {
  const keyReg = new Map();
  const fields = [];
  const unresolved = [];
  linesOf(methodText).forEach((line, index) => {
    const lineNo = index + 1;
    const keyGet = line.match(/^\s*sget-object\s+(\w+),\s+Lcom\/motorola\/camera\/settings\/SettingsManager;->(\w+):Lcom\/motorola\/camera\/settings\/SettingsManager\$Key;\s*$/);
    if (keyGet) {
      keyReg.set(keyGet[1], keyGet[2]);
      return;
    }
    const move = line.match(/^\s*move-object(?:\/from16|\/16)?\s+(\w+),\s+(\w+)\s*$/);
    if (move) {
      if (keyReg.has(move[2])) keyReg.set(move[1], keyReg.get(move[2]));
      else keyReg.delete(move[1]);
      return;
    }
    const writesReg = line.match(/^\s*(?:const(?:-[^\s]+|\/\d+)?|move-result(?:-object)?|new-instance|iget(?:-[^\s]+)?|sget(?:-[^\s]+)?)\s+(\w+)\b/);
    if (writesReg && !keyGet) keyReg.delete(writesReg[1]);
    const call = line.match(/^\s*invoke-static(?:\/range)?\s+\{([^}]+)\},\s+Lcom\/motorola\/camera\/settings\/SettingsFactory;->addSetting\(/);
    if (!call) return;
    const args = expandRegisters(call[1].trim());
    const field = keyReg.get(args[1]);
    if (!field) unresolved.push({ line: lineNo, args });
    else fields.push({ field, line: lineNo });
  });
  if (unresolved.length) {
    const sample = unresolved.slice(0, 5).map((item) => `${item.line}:${item.args.join(',')}`).join('; ');
    throw new Error(`Unresolved addSetting key registers (${unresolved.length}): ${sample}`);
  }
  return fields;
}

function requireText(file, needle) {
  const text = readFileSync(file, 'utf8');
  if (!text.includes(needle)) throw new Error(`${file} missing ${needle}`);
  return text;
}

function collectScenes(node, scenes) {
  if (!node || typeof node !== 'object') return;
  if (Array.isArray(node)) {
    node.forEach((item) => collectScenes(item, scenes));
    return;
  }
  if (typeof node.override_scene === 'string') scenes.add(node.override_scene);
  for (const value of Object.values(node)) collectScenes(value, scenes);
}

function summarizeIq(iq) {
  const device = iq.ctwo;
  if (!device) throw new Error('iq_config_ctwo has no ctwo object');
  const scenes = new Set();
  collectScenes(device.scene_selection_advanced_overrides, scenes);
  const sensors = (device['lux-idx-to-std-params'] ?? []).map((row) => row['sensor-name']);
  return {
    device_key: 'ctwo',
    top_level_keys: Object.keys(device).sort(),
    scene_selection_cameras: Object.keys(device.scene_selection_advanced_overrides ?? {}).sort(),
    override_scenes: [...scenes].sort(),
    zsl_modes: Object.keys(device.zsl_settings ?? {}).sort(),
    uhdr_modes: Object.keys(device.uhdr_settings ?? {}).sort(),
    qc_mfnr_keys: Object.keys(device.qc_mfnr_settings ?? {}).sort(),
    sensors,
    video_nv_prompt_lux: device.video_nv_prompt_lux ?? null,
    software_flash: device.software_flash ?? null,
  };
}

function summarizeFeatures(appFeature) {
  const features = appFeature.fs.map((entry) => {
    const row = { feature: entry.f };
    if (Object.hasOwn(entry, 'value')) row.value = entry.value;
    if (Object.hasOwn(entry, 'region')) row.region = entry.region;
    if (Object.hasOwn(entry, 'array')) row.array = entry.array;
    return row;
  });
  features.sort((a, b) => a.feature.localeCompare(b.feature));
  return { device: appFeature.d, count: features.length, features };
}

function summarizeMcf(configDir) {
  const encrypted = join(configDir, 'mcf_config_ctwo');
  const decrypted = join(configDir, 'mcf_config_ctwo.decrypted.json');
  const encryptedBytes = readFileSync(encrypted);
  const parsed = JSON.parse(readFileSync(decrypted, 'utf8'));
  const rootKeys = Object.keys(parsed).sort();
  const deviceKeys = parsed.ctwo && typeof parsed.ctwo === 'object' ? Object.keys(parsed.ctwo).sort() : [];
  return {
    encrypted_asset_copy: encrypted,
    encrypted_byte_length: encryptedBytes.length,
    decrypted_analysis_copy: decrypted,
    decrypted_root_keys: rootKeys,
    decrypted_ctwo_keys: deviceKeys,
    runtime_note: 'The camera process reads the asset named by McfUtil.getFeasibleDeviceName, not this configs directory.',
  };
}

function publicId(publicXml, type, name) {
  const match = publicXml.match(new RegExp(`<public type="${type}" name="${name}" id="(0x[0-9a-fA-F]+)" \\/>`));
  if (!match) throw new Error(`Missing public ${type} ${name}`);
  return { name, id: match[1].toLowerCase(), decimal: Number.parseInt(match[1], 16) };
}

export function extractReference(reRoot = RE_ROOT) {
  const decompiled = join(reRoot, 'decompiled', 'MotCamera4_v3');
  const settingsPath = join(decompiled, 'smali', 'com', 'motorola', 'camera', 'settings', 'SettingsManager.smali');
  const factoryPath = join(decompiled, 'smali', 'com', 'motorola', 'camera', 'settings', 'SettingsFactory.smali');
  const debugUiPath = join(decompiled, 'smali', 'com', 'motorola', 'camera', 'ui', 'controls_2020', 'settings', 'preferences', 'DebugUiPreference.smali');
  const helperPath = join(decompiled, 'smali', 'com', 'motorola', 'camera', 'ui', 'controls_2020', 'settings', 'helper', 'DebugBroadcastHelper.smali');
  const receiverPath = join(decompiled, 'smali', 'com', 'motorola', 'camera', 'SecureCamera$1.smali');
  const menuPath = join(decompiled, 'smali', 'com', 'motorola', 'camera', 'instrumentreport', 'DeveloperMenu.smali');
  const generalPath = join(decompiled, 'smali', 'com', 'motorola', 'camera', 'ui', 'controls_2020', 'settings', 'fragment', 'GeneralSettingsFragment.smali');
  const fragmentPath = join(decompiled, 'smali', 'com', 'motorola', 'camera', 'fragments', 'SettingsManagerFragment.smali');
  const debugFragmentPath = join(decompiled, 'smali', 'com', 'motorola', 'camera', 'ui', 'controls_2020', 'settings', 'fragment', 'DebugPreferencesFragment.smali');
  const mcfJsonPath = join(decompiled, 'smali', 'com', 'motorola', 'camera', 'fsm', 'camera', 'states', 'runnables', 'McfJsonConfig.smali');
  const mcfUtilPath = join(decompiled, 'smali', 'com', 'motorola', 'camera', 'shared', 'McfUtil.smali');
  const utilPath = join(decompiled, 'smali', 'com', 'motorola', 'camera', 'Util.smali');
  const propIntPath = join(decompiled, 'smali', 'com', 'motorola', 'camera', 'shared', 'DeviceProperties$DEV_PROP_INT.smali');
  const propStrPath = join(decompiled, 'smali', 'com', 'motorola', 'camera', 'shared', 'DeviceProperties$DEV_PROP_STR.smali');
  const uiFactoryPath = join(decompiled, 'smali', 'com', 'motorola', 'camera', 'ui', 'uicomponents', 'UIComponentFactory.smali');
  const manifestPath = join(decompiled, 'AndroidManifest.xml');
  const debugPrefsXml = join(decompiled, 'res', 'xml', 'settings_list_debug_preferences.xml');
  const rootPrefsXml = join(decompiled, 'res', 'xml', 'settings_list_root_preferences.xml');
  const developerMenuXml = join(decompiled, 'res', 'layout', 'developer_menu.xml');
  const sceneDebugXml = join(decompiled, 'res', 'layout', 'scene_mode_debug_menu.xml');
  const containerXml = join(decompiled, 'res', 'layout', 'settings_manager_container.xml');

  const settingsText = readFileSync(settingsPath, 'utf8');
  const factoryText = readFileSync(factoryPath, 'utf8');
  const debugUiText = requireText(debugUiPath, 'com.motorola.camera3.DEBUG');
  const helperText = requireText(helperPath, 'LocalBroadcastManager');
  const receiverText = requireText(receiverPath, 'com.motorola.camera3.EXTRA_ACTION');
  const menuText = readFileSync(menuPath, 'utf8');
  const generalText = readFileSync(generalPath, 'utf8');
  const fragmentText = requireText(fragmentPath, 'mcf_override_config');
  const debugFragmentText = readFileSync(debugFragmentPath, 'utf8');
  const mcfJsonText = readFileSync(mcfJsonPath, 'utf8');
  const mcfUtilText = readFileSync(mcfUtilPath, 'utf8');
  const utilText = readFileSync(utilPath, 'utf8');
  const propIntText = readFileSync(propIntPath, 'utf8');
  const propStrText = readFileSync(propStrPath, 'utf8');
  const uiFactoryText = readFileSync(uiFactoryPath, 'utf8');
  const manifestText = readFileSync(manifestPath, 'utf8');
  const debugPrefs = readFileSync(debugPrefsXml, 'utf8');
  const rootPrefs = readFileSync(rootPrefsXml, 'utf8');
  const developerMenu = readFileSync(developerMenuXml, 'utf8');
  const sceneDebug = readFileSync(sceneDebugXml, 'utf8');
  const container = readFileSync(containerXml, 'utf8');
  const { byId, nameToValue, publicXml } = loadStrings(decompiled);

  const clinit = methodBody(settingsText, '.method public static constructor <clinit>()V');
  const keys = parseClinitKeys(clinit.text, byId, clinit.startLine);
  const sputCount = (clinit.text.match(/^\s*sput-object\s+\w+,\s+Lcom\/motorola\/camera\/settings\/SettingsManager;->\w+:Lcom\/motorola\/camera\/settings\/SettingsManager\$Key;\s*$/gm) ?? []).length;
  if (keys.length !== sputCount) {
    throw new Error(`Parsed ${keys.length} keys but found ${sputCount} Key sput-object lines`);
  }
  const byField = new Map(keys.map((key) => [key.field, key]));
  for (const field of EXPLICIT_APP_FIELDS) {
    if (!byField.has(field)) throw new Error(`Missing explicit app-tab field ${field}`);
  }
  const explicitNames = new Set(EXPLICIT_APP_FIELDS.map((field) => byField.get(field).name));

  const factoryMethod = methodBody(factoryText, '.method public static getSettingsMap()Ljava/util/HashMap;');
  const factoryAdds = parseFactoryKeyFields(factoryMethod.text);
  const factoryFields = new Set(factoryAdds.map((add) => add.field));
  for (const field of factoryFields) {
    if (!byField.has(field)) throw new Error(`SettingsFactory references unknown key ${field}`);
  }

  const decorated = keys.map((key) => {
    const tabs = factoryFields.has(key.field) ? tabsForName(key.name, explicitNames) : [];
    return {
      field: key.field,
      name: key.name,
      type: key.type,
      ...controlForType(key.type),
      name_source: key.name_source,
      resource_id: key.resource_id,
      resource_name: key.resource_name,
      settings_manager_line: key.line,
      in_settings_factory: factoryFields.has(key.field),
      tabs,
    };
  }).sort((a, b) => a.name.localeCompare(b.name) || a.field.localeCompare(b.field));

  const tabKeys = Object.fromEntries(TAB_ORDER.map((tab) => [
    tab,
    decorated.filter((key) => key.tabs.includes(tab)).map((key) => ({
      field: key.field,
      name: key.name,
      type: key.type,
      control: key.control,
      view_type: key.view_type,
      settings_manager_line: key.settings_manager_line,
    })),
  ]));

  const action = 'com.motorola.camera3.DEBUG';
  const extra = 'com.motorola.camera3.EXTRA_ACTION';
  if (!helperText.includes(`"${action}"`) || !debugUiText.includes(`"${action}"`) || !debugUiText.includes(`"${extra}"`)) {
    throw new Error('Debug action strings diverged from DebugBroadcastHelper / DebugUiPreference');
  }
  if (manifestText.includes(action)) {
    throw new Error('Manifest unexpectedly registers the debug action; revisit ADB reachability');
  }

  const stringRef = (name) => ({
    name,
    id: publicId(publicXml, 'string', name).id,
    value: nameToValue.get(name) ?? null,
  });
  const idRef = (name) => publicId(publicXml, 'id', name);
  const layoutRef = (name) => publicId(publicXml, 'layout', name);
  const xmlRef = (name) => publicId(publicXml, 'xml', name);

  const appFeature = JSON.parse(readFileSync(join(reRoot, 'configs', 'app_feature_ctwo'), 'utf8'));
  const iqConfig = JSON.parse(readFileSync(join(reRoot, 'configs', 'iq_config_ctwo'), 'utf8'));
  const features = summarizeFeatures(appFeature);
  const iq = summarizeIq(iqConfig);
  const mcfCopy = summarizeMcf(join(reRoot, 'configs'));
  const packageMatch = manifestText.match(/package="([^"]+)"/);
  if (!packageMatch) throw new Error('Manifest package attribute missing');

  const hint = 'mcf_override_config\n-> adb shell setprop log.tag.mcf.override.config D';
  if (!fragmentText.includes(hint.replaceAll('\n', '\\n'))) {
    throw new Error('MCF override hint string missing');
  }

  return {
    schema_version: 1,
    source: {
      app: 'MotCamera4_v3',
      version_annotation: 'MotCamera4-v9.1.22.52_release',
      device: 'ctwo',
      device_product: 'Motorola Edge 50 Ultra',
      manifest_package: packageMatch[1],
      requested_mod_package: 'com.motorola.camera3.mod',
      package_note: 'Broadcast action strings are literals under com.motorola.camera3. A package rename to com.motorola.camera3.mod does not rewrite them.',
      manifest_line: lineOf(manifestText, 'package="com.motorola.camera3"'),
      version_line: lineOf(debugUiText, 'MotCamera4-v9.1.22.52_release'),
    },
    developer_menu: {
      gate: {
        symbol: 'com.motorola.camera.instrumentreport.DeveloperMenu.isMenuEnabled',
        source: 'smali/com/motorola/camera/instrumentreport/DeveloperMenu.smali',
        method_line: lineOf(menuText, '.method public static isMenuEnabled()Z'),
        dead_read: {
          symbol: 'com.motorola.camera.Util.USERDEBUG_BUILD',
          line: lineOf(menuText, 'USERDEBUG_BUILD'),
          observation: 'The sget-boolean result is overwritten by the next sget-object before it is used.',
        },
        properties: [
          {
            enum: 'PROPERTY_KEY_IS_PRODUCTION',
            property: 'ro.product.is_production',
            line: lineOf(propStrText, 'ro.product.is_production'),
          },
          {
            enum: 'SECURE_DEVICE',
            property: 'ro.boot.secure_hardware',
            line: lineOf(propIntText, 'ro.boot.secure_hardware'),
          },
          {
            enum: 'ROOTED_DEVICE',
            property: 'persist.qe',
            line: lineOf(propStrText, 'persist.qe'),
            equals: 'qe 1/1',
          },
        ],
        enabled_when: [
          'ro.product.is_production equals "false", ignoring case',
          'CameraApp.isUserAMonkey() is false',
          'persist.qe equals "qe 1/1" together with ro.boot.secure_hardware == 1 leaves the cached flag false; every other non-production combination caches true',
        ],
        settings_entry_removed_when_disabled: {
          file: 'smali/com/motorola/camera/ui/controls_2020/settings/fragment/GeneralSettingsFragment.smali',
          line: lineOf(generalText, 'DeveloperMenu;->isMenuEnabled()Z'),
          preference_string_id: '0x7f120496',
          preference_key: stringRef('settings_list_about_debug_key'),
        },
      },
      entry: {
        title: stringRef('main_setting_debug_ui'),
        preference_key: stringRef('settings_list_about_debug_key'),
        fragment: 'com.motorola.camera.ui.controls_2020.settings.fragment.DebugPreferencesFragment',
        root_xml: 'res/xml/settings_list_root_preferences.xml',
        root_xml_line: lineOf(rootPrefs, 'settings_list_about_debug_key'),
        debug_xml: 'res/xml/settings_list_debug_preferences.xml',
        debug_xml_resource: xmlRef('settings_list_debug_preferences'),
        debug_fragment_line: lineOf(debugFragmentText, '0x7f150005'),
        preference_class: 'com.motorola.camera.ui.controls_2020.settings.preferences.DebugUiPreference',
        layout_key: stringRef('settings_list_about_debug_layout_key'),
        layout: layoutRef('developer_menu'),
      },
      layout_ids: {
        debug_menu_layout: idRef('debug_menu_layout'),
        debug_ui_tab_layout: idRef('debug_ui_tab_layout'),
        debug_ui_pager: idRef('debug_ui_pager'),
        debug_ui_search: idRef('debug_ui_search'),
        debug_ui_commend: idRef('debug_ui_commend'),
        settings_manager_list: idRef('settings_manager_list'),
        container_layout: layoutRef('settings_manager_container'),
      },
      tabs: {
        filter_source: 'smali/com/motorola/camera/ui/controls_2020/settings/preferences/DebugUiPreference.smali',
        on_bind_line: lineOf(debugUiText, '.method public final onBindViewHolder'),
        auto_test_symbol: 'com.motorola.camera.Util.AUTO_TEST',
        auto_test_line: lineOf(utilText, 'CAMERA_AUTO_TEST'),
        normal_tabs: [
          {
            id: 'app',
            title: stringRef('settings_app_tab_label'),
            fragment: 'com.motorola.camera.fragments.SettingsManagerFragment',
            bundle_mcf: false,
            filter: 'mName contains ".debug_" OR mName contains "dump_" OR mName equals PREVIEW_SIZE, ACTIVITY_TIMEOUT, or COMPOSITION_GUIDE',
            filter_lines: [
              lineOf(debugUiText, '".debug_"'),
              lineOf(debugUiText, '"dump_"'),
            ],
          },
          {
            id: 'mcf_algorithm',
            title: stringRef('settings_mcf_algorithm_tab_label'),
            fragment: 'com.motorola.camera.fragments.SettingsManagerFragment',
            bundle_mcf: true,
            filter: 'mName contains "mcf_debug_" OR mName contains "ai_debug_"',
            shows_mcf_override_hint: true,
          },
          {
            id: 'iq',
            title: stringRef('settings_iq_tab_label'),
            fragment: 'com.motorola.camera.fragments.SettingsManagerFragment',
            bundle_mcf: false,
            filter: 'mName contains "tuning_debug_"',
          },
          {
            id: 'kpi',
            title: stringRef('kpi_tab_label'),
            fragment: 'com.motorola.camera.fragments.KpiReportFragment',
            extra_message: 'KpiReportFragment',
          },
          {
            id: 'camera_info',
            title: stringRef('debug_camera_info'),
            fragment: 'com.motorola.camera.fragments.CalibrationDataFragment',
          },
        ],
        auto_test_tabs: [
          {
            id: 'app',
            title: stringRef('settings_app_tab_label'),
            fragment: 'com.motorola.camera.fragments.SettingsManagerFragment',
            bundle_mcf: false,
            filter: 'every key in SettingsManager.mSettingsMap',
          },
          {
            id: 'kpi',
            title: stringRef('kpi_tab_label'),
            fragment: 'com.motorola.camera.fragments.KpiReportFragment',
          },
          {
            id: 'camera_info',
            title: stringRef('debug_camera_info'),
            fragment: 'com.motorola.camera.fragments.CalibrationDataFragment',
          },
        ],
      },
      row_controls: {
        source: 'smali/com/motorola/camera/fragments/SettingsManagerFragment.smali',
        method: 'getKeyViewType',
        method_line: lineOf(fragmentText, '.method public static getKeyViewType'),
        boolean_is_switch: true,
        switch_widget: 'androidx.appcompat.widget.SwitchCompat',
        search_key: 'LAST_DEBUG_UI_SETTING_SEARCH_QUERY',
      },
      scene_debug_overlay: {
        layout: 'res/layout/scene_mode_debug_menu.xml',
        stub_id: idRef('scene_debug_stub'),
        spinner_id: idRef('current_scene_picker'),
        default_visibility: sceneDebug.includes('android:visibility="gone"') ? 'gone' : 'unspecified',
        created_when: 'DeveloperMenu.isMenuEnabled() and FeaturesUtil.SUPPORT_AI',
        factory_line: lineOf(uiFactoryText, 'SceneDetectionDebugComponent'),
      },
    },
    debug_broadcast: {
      helper: 'com.motorola.camera.ui.controls_2020.settings.helper.DebugBroadcastHelper',
      action,
      extra,
      delivery: 'androidx.localbroadcastmanager.content.LocalBroadcastManager',
      register_line: lineOf(helperText, 'LocalBroadcastManager;->getInstance'),
      action_line: lineOf(helperText, action),
      receiver: 'com.motorola.camera.SecureCamera$1',
      receiver_class_id_decimal: 17,
      receiver_line: lineOf(receiverText, extra),
      adb_reaches_helper: false,
      adb_reason: 'The helper registers with LocalBroadcastManager. AndroidManifest.xml has no receiver for com.motorola.camera3.DEBUG. Context.sendBroadcast from DebugUiPreference and adb shell am broadcast are process-global broadcasts, so they do not invoke this receiver.',
      adb_commands_that_reach_helper: [],
      in_process_intents: [
        {
          sender: 'DebugUiPreference.onAttached',
          line: lineOf(debugUiText, '.method public final onAttached()V'),
          action,
          extra,
          extra_value: 0,
          transport: 'Context.sendBroadcast',
          helper_effect_if_delivered_locally: 'invokes enteringAction',
        },
        {
          sender: 'DebugUiPreference.onDetached',
          line: lineOf(debugUiText, '.method public final onDetached()V'),
          action,
          extra,
          extra_value: 1,
          transport: 'Context.sendBroadcast',
          helper_effect_if_delivered_locally: 'invokes exitingAction',
        },
      ],
      local_receiver_effects: [
        { extra_value: 0, callback: 'enteringAction' },
        { extra_value: 1, callback: 'exitingAction' },
        { extra_value: 'any other int, default -1', callback: 'ignored' },
      ],
      observed_callback_bodies: [
        {
          owner: 'DebugBroadcastStateChangeListener$1.invoke',
          observation: 'Both $r8$classId branches call getClass() and return Unit. No setting write is present in this decompile.',
        },
        {
          owner: 'DebugIdComponent',
          observation: 'Constructor passes a null enteringAction and a non-null exitingAction. The helper does not itself toggle a SettingsManager key.',
        },
      ],
      unrelated_extra_action_user: {
        action: 'com.motorola.camera3.CLI_CONTENT_ACTION_RECEIVER',
        observation: 'CameraPreview, TimerCountdown, GalleryThumbnailChangeController, and CliContentManager reuse the extra name with this other action. DebugBroadcastHelper does not register that action.',
      },
    },
    settings_keys: {
      static_key_count: decorated.length,
      factory_key_count: factoryFields.size,
      explicit_app_names: [...explicitNames].sort(),
      tabs: tabKeys,
      tab_counts: Object.fromEntries(TAB_ORDER.map((tab) => [tab, tabKeys[tab].length])),
    },
    ctwo: {
      app_features: features,
      iq,
      mcf_override: {
        ui_hint: hint,
        ui_hint_line: lineOf(fragmentText, 'mcf_override_config'),
        ui_hint_visible_when: 'SettingsManagerFragment arguments boolean "mcf" is true (MCF&Algorithm tab)',
        log_tag: 'mcf.override.config',
        log_level: 'Log.DEBUG (3)',
        property_enum: 'DeviceProperties.DEV_PROP_INT.MCF_OVERRIDE',
        property: 'persist.camera.mot.mcf_override',
        property_line: lineOf(propIntText, 'persist.camera.mot.mcf_override'),
        test_build_symbol: 'com.motorola.camera.Util.TEST_BUILD',
        test_build_line: lineOf(utilText, 'test-keys'),
        test_build_means: 'android.os.Build.TAGS contains "test-keys"',
        decision_line: lineOf(mcfJsonText, 'mcf.override.config'),
        decision: 'Override is requested only when TEST_BUILD is true and either Log.isLoggable("mcf.override.config", DEBUG) or getInt(MCF_OVERRIDE) == 1. Otherwise McfJsonConfig passes false to readMcfConfig.',
        override_reader: 'McfUtil.readOverrideMcfConfig',
        override_directory: 'Context.getFilesDir()',
        override_filename_prefix: 'mcf_config_ plus stripVariant(platform)',
        ctwo_prefix: 'mcf_config_ctwo',
        override_file_rule: 'listFiles keeps files whose names start with that prefix. The method accepts exactly 1 or 2 matches, parses them as JSON, consolidates them, then parses a sibling mcf_config_base_*_sensor file from the same directory and merges common-device onto the device object.',
        missing_override_error: 'IOException "MCF config override file not found", wrapped by McfJsonConfig as IllegalArgumentException "MCF configuration is invalid"',
        baked_reader: 'McfUtil.decryptJSonConfig',
        baked_asset_name: 'mcf_config_<feasible device>, which is mcf_config_ctwo when that asset exists',
        baked_transform: 'Cipher.getInstance("Blowfish") init mode 2 (DECRYPT_MODE), then GZIPInputStream over CipherInputStream of AssetManager.open(assetName)',
        baked_key_line: lineOf(mcfUtilText, 'PsDnGz8m'),
        baked_cipher_line: lineOf(mcfUtilText, 'Blowfish'),
        iq_loader: 'JsonConfig.getAssetConfig plaintext asset iq_config_<stripVariant(device)>, then JSONObject.getJSONObject(device)',
        iq_line: lineOf(readFileSync(join(decompiled, 'smali', 'com', 'motorola', 'camera', 'JsonConfig.smali'), 'utf8'), 'iq_config_'),
        app_feature_loader: 'AppFeatures loads plaintext asset app_feature_<device> and reads the fs array',
        tuning_reader: 'McfUtil.readTuningMcfConfig',
        tuning_result: 'UTF-8 bytes of "{}" after TuningProviderHelper.WHITE_LIST (an EmptySet) is consulted. This build does not load a tuning JSON from assets in that method.',
        analysis_copies: mcfCopy,
      },
    },
    layout_files_read: [
      'res/layout/developer_menu.xml',
      'res/layout/scene_mode_debug_menu.xml',
      'res/layout/settings_manager_container.xml',
      'res/xml/settings_list_debug_preferences.xml',
      'res/xml/settings_list_root_preferences.xml',
    ],
    layout_evidence: {
      developer_menu_ids: [...developerMenu.matchAll(/android:id="@\+?id\/([^"]+)"/g)].map((match) => match[1]),
      scene_debug_ids: [...sceneDebug.matchAll(/android:id="@\+?id\/([^"]+)"/g)].map((match) => match[1]),
      container_ids: [...container.matchAll(/android:id="@\+?id\/([^"]+)"/g)].map((match) => match[1]),
      debug_preference_class: debugPrefs.includes('DebugUiPreference'),
    },
  };
}

function mdEscape(value) {
  return String(value).replaceAll('|', '\\|');
}

export function renderMarkdown(ref) {
  const app = ref.settings_keys.tabs.app;
  const mcf = ref.settings_keys.tabs.mcf_algorithm;
  const iq = ref.settings_keys.tabs.iq;
  const switches = app.filter((key) => key.control === 'switch');
  const featureLines = ref.ctwo.app_features.features.map((feature) => {
    const extras = [];
    if (Object.hasOwn(feature, 'value')) extras.push(`value=${JSON.stringify(feature.value)}`);
    if (Object.hasOwn(feature, 'region')) extras.push(`region=${feature.region}`);
    if (Object.hasOwn(feature, 'array')) extras.push(`array=${JSON.stringify(feature.array)}`);
    return `- \`${feature.feature}\`${extras.length ? ` (${extras.join(', ')})` : ''}`;
  });
  return `# MotCamera4 v9.1.22.52 developer menu and ctwo tunables

This note records what the decompiled \`MotCamera4_v3\` tree and the \`ctwo\` config files actually contain. The machine-readable catalog is \`docs/TUNABLE_KEYS_REFERENCE.json\`. Package observed in \`AndroidManifest.xml\` line ${ref.source.manifest_line} is \`${ref.source.manifest_package}\`. The version string \`MotCamera4-v9.1.22.52_release\` is the Kotlin metadata on \`DebugUiPreference\` line ${ref.source.version_line}. Action strings stay under \`com.motorola.camera3\` when the installed package is renamed to \`com.motorola.camera3.mod\`.

## Developer menu gate

\`DeveloperMenu.isMenuEnabled()\` (\`DeveloperMenu.smali\` line ${ref.developer_menu.gate.method_line}) caches \`mDebug\`.

\`Util.USERDEBUG_BUILD\` is read at line ${ref.developer_menu.gate.dead_read.line} and then overwritten by the next \`sget-object\` before any branch uses it.

The method then reads:

- \`ro.product.is_production\` (\`DeviceProperties.DEV_PROP_STR.PROPERTY_KEY_IS_PRODUCTION\`, line ${ref.developer_menu.gate.properties[0].line})
- \`ro.boot.secure_hardware\` (\`DEV_PROP_INT.SECURE_DEVICE\`, line ${ref.developer_menu.gate.properties[1].line})
- \`persist.qe\` (\`DEV_PROP_STR.ROOTED_DEVICE\`, line ${ref.developer_menu.gate.properties[2].line}), compared with the literal \`qe 1/1\`

The cached flag is true when \`ro.product.is_production\` equals \`false\` (case-insensitive) and the pair \`persist.qe == "qe 1/1"\` plus \`ro.boot.secure_hardware == 1\` is absent. Any other \`is_production\` value caches false. The method returns true only when that flag is true and \`CameraApp.isUserAMonkey()\` is false.

\`GeneralSettingsFragment\` line ${ref.developer_menu.gate.settings_entry_removed_when_disabled.line} removes preference key \`settings_list_about_debug_key\` when the menu is disabled. The surviving row is titled \`Debug\` and opens \`DebugPreferencesFragment\`, which inflates \`res/xml/settings_list_debug_preferences.xml\` (\`0x7f150005\`). That screen contains one \`DebugUiPreference\` with key \`settings_list_about_debug_layout_key\` and layout \`developer_menu\`.

## Tabs

\`DebugUiPreference.onBindViewHolder\` (line ${ref.developer_menu.tabs.on_bind_line}) fills a \`TabLayout\` (\`debug_ui_tab_layout\`, \`0x7f0a013b\`) and \`ViewPager2\` (\`debug_ui_pager\`, \`0x7f0a0139\`).

When \`Util.AUTO_TEST\` is false the pages are:

| Tab title | Fragment | Key filter |
| --- | --- | --- |
| App | SettingsManagerFragment | \`.debug_\` or \`dump_\` or the names of \`PREVIEW_SIZE\`, \`ACTIVITY_TIMEOUT\`, \`COMPOSITION_GUIDE\` |
| MCF&Algorithm | SettingsManagerFragment (\`mcf=true\`) | \`mcf_debug_\` or \`ai_debug_\` |
| IQ | SettingsManagerFragment | \`tuning_debug_\` |
| KPI (msec) | KpiReportFragment | bundle \`EXTRA_MESSAGE=KpiReportFragment\` |
| CAMERA INFO | CalibrationDataFragment | no SettingsManager filter |

\`Util.AUTO_TEST\` is true when \`ro.product.is_production\` equals \`false\` and \`Log.isLoggable("CAMERA_AUTO_TEST", DEBUG)\` is true (\`Util.smali\` line ${ref.developer_menu.tabs.auto_test_line}). In that mode the pager has three pages: App (every key in \`mSettingsMap\`), KPI, and CAMERA INFO.

The lists below are the keys \`SettingsFactory.getSettingsMap\` passes to \`addSetting\` whose \`mName\` matches the normal-mode filter. Runtime branches inside \`getSettingsMap\` can still skip an \`addSetting\`. Static key count is ${ref.settings_keys.static_key_count}. Factory \`addSetting\` key count is ${ref.settings_keys.factory_key_count}.

Normal-mode counts: App ${ref.settings_keys.tab_counts.app} (${switches.length} boolean switches), MCF&Algorithm ${ref.settings_keys.tab_counts.mcf_algorithm}, IQ ${ref.settings_keys.tab_counts.iq}.

Boolean rows use \`SwitchCompat\` (\`SettingsManagerFragment.getKeyViewType\` returns 0, line ${ref.developer_menu.row_controls.method_line}). Integer and long use view type 1, float and double use 2, \`String\` uses 3, and the remaining types open a dialog. Search text is stored under \`LAST_DEBUG_UI_SETTING_SEARCH_QUERY\`.

Explicit App-tab names that do not contain \`.debug_\`:

${[...ref.settings_keys.explicit_app_names].map((name) => `- \`${name}\``).join('\n')}

The full field, type, and \`SettingsManager.smali\` line for every matching key is the \`settings_keys.tabs\` object in the JSON catalog.

\`scene_mode_debug_menu.xml\` is a \`ViewStub\` (\`scene_debug_stub\`) whose root starts \`gone\`. \`UIComponentFactory\` line ${ref.developer_menu.scene_debug_overlay.factory_line} constructs \`SceneDetectionDebugComponent\` when the developer menu is enabled and \`FeaturesUtil.SUPPORT_AI\` is true. The spinner id is \`current_scene_picker\`.

## DebugBroadcastHelper

\`DebugBroadcastHelper.registerActionReceiver\` (line ${ref.debug_broadcast.register_line}) adds action \`com.motorola.camera3.DEBUG\` and registers \`SecureCamera$1\` on \`LocalBroadcastManager\`. The receiver (line ${ref.debug_broadcast.receiver_line}) reads \`com.motorola.camera3.EXTRA_ACTION\` with default \`-1\`.

| extra value | callback |
| --- | --- |
| 0 | \`enteringAction\` |
| 1 | \`exitingAction\` |
| any other value | ignored |

\`DebugUiPreference.onAttached\` (line ${ref.debug_broadcast.in_process_intents[0].line}) and \`onDetached\` (line ${ref.debug_broadcast.in_process_intents[1].line}) build that same action and send it with \`Context.sendBroadcast\`, extra 0 on attach and extra 1 on detach. That call is a process-global broadcast. The helper's receiver is local. \`AndroidManifest.xml\` does not declare a receiver for \`com.motorola.camera3.DEBUG\`.

\`adb shell am broadcast -a com.motorola.camera3.DEBUG --ei com.motorola.camera3.EXTRA_ACTION 0 -p com.motorola.camera3.mod\` is a system broadcast. The helper receiver stays on \`LocalBroadcastManager\`, so \`enteringAction\` and \`exitingAction\` stay uninvoked. Extra value 1 has the same delivery. The JSON field \`debug_broadcast.adb_commands_that_reach_helper\` is an empty array.

\`DebugBroadcastStateChangeListener$1.invoke\` calls \`getClass()\` and returns \`Unit\`. \`DebugIdComponent\` passes a null entering callback. Those decompiled callback bodies contain no \`SettingsManager\` write.

\`com.motorola.camera3.EXTRA_ACTION\` is also put on action \`com.motorola.camera3.CLI_CONTENT_ACTION_RECEIVER\` by the CLI content path. \`DebugBroadcastHelper\` does not register that action.

## ctwo feature flags

\`AppFeatures\` loads plaintext asset \`app_feature_\` plus the stripped device name and reads array \`fs\`. \`configs/app_feature_ctwo\` has device \`${ref.ctwo.app_features.device}\` and ${ref.ctwo.app_features.count} features:

${featureLines.join('\n')}

## IQ asset versus MCF override

\`JsonConfig\` line ${ref.ctwo.mcf_override.iq_line} opens plaintext asset \`iq_config_\` plus \`stripVariant(device)\` and then \`getJSONObject\` for that device. For this config the object key is \`ctwo\`. Top-level IQ sections:

${ref.ctwo.iq.top_level_keys.map((key) => `- \`${key}\``).join('\n')}

Scene-selection cameras: ${ref.ctwo.iq.scene_selection_cameras.map((name) => `\`${name}\``).join(', ')}.

Override scene names found under \`scene_selection_advanced_overrides\`:

${ref.ctwo.iq.override_scenes.map((name) => `- \`${name}\``).join('\n')}

Lux sensors: ${ref.ctwo.iq.sensors.map((name) => `\`${name}\``).join(', ')}.

\`video_nv_prompt_lux\` is show-on ${ref.ctwo.iq.video_nv_prompt_lux.show_turn_on_tips}, show-off ${ref.ctwo.iq.video_nv_prompt_lux.show_turn_off_tips}.

Editing \`iq_config_ctwo\` (the plaintext asset) changes those IQ tables. That path does not go through \`McfUtil.decryptJSonConfig\`.

MCF static config is chosen in \`McfJsonConfig.getConfiguration\` (decision at line ${ref.ctwo.mcf_override.decision_line}).

- \`Util.TEST_BUILD\` (line ${ref.ctwo.mcf_override.test_build_line}) is true when \`Build.TAGS\` contains \`test-keys\`.
- On a test-keys build the override flag is the OR of \`Log.isLoggable("mcf.override.config", DEBUG)\` and \`getInt(persist.camera.mot.mcf_override) == 1\` (property line ${ref.ctwo.mcf_override.property_line}).
- The MCF&Algorithm tab shows the literal hint at \`SettingsManagerFragment.smali\` line ${ref.ctwo.mcf_override.ui_hint_line}: \`adb shell setprop log.tag.mcf.override.config D\`.
- When the flag is true, \`McfUtil.readOverrideMcfConfig\` lists \`Context.getFilesDir()\` for files whose names start with \`mcf_config_ctwo\`, accepts one or two matches, and merges a \`mcf_config_base_*_sensor\` file from that same directory. A missing file throws \`IOException\` \`"MCF config override file not found"\`.
- When the flag is false, \`McfUtil.decryptJSonConfig\` opens asset \`mcf_config_ctwo\` (or the India/RAM name from \`getFeasibleDeviceName\`), decrypts it with Blowfish \`DECRYPT_MODE\`, and gunzips it. The cipher name is at \`McfUtil.smali\` line ${ref.ctwo.mcf_override.baked_cipher_line}. The key literal is at line ${ref.ctwo.mcf_override.baked_key_line}.

\`configs/mcf_config_ctwo\` is ${ref.ctwo.mcf_override.analysis_copies.encrypted_byte_length} bytes. \`configs/mcf_config_ctwo.decrypted.json\` is an analysis copy whose root keys are ${ref.ctwo.mcf_override.analysis_copies.decrypted_root_keys.map((key) => `\`${key}\``).join(', ')}. The process reads the APK asset, not that configs directory.

\`Mcf.doInitByHighPriority\` passes the MCF bytes and \`readTuningMcfConfig\` bytes into \`native_init\`. \`readTuningMcfConfig\` returns the UTF-8 bytes of \`{}\` after checking \`TuningProviderHelper.WHITE_LIST\`, which is an \`EmptySet\` in this decompile. Shared preference \`MCF_DEBUG_LOGDD_MASK\` is passed as the log mask integer.

## Limits

- Tab membership is the static \`addSetting\` set filtered the way \`onBindViewHolder\` filters \`mSettingsMap\`. A branch that skips \`addSetting\` at runtime will hide that row.
- No manifest receiver and no \`LocalBroadcastManager.sendBroadcast\` of \`com.motorola.camera3.DEBUG\` were found, so the helper callbacks have no observed sender that can reach them.
- \`readTuningMcfConfig\` does not expose the IQ asset. IQ and app features are separate plaintext assets.
`;
}

function isDirectRun() {
  const entry = process.argv[1];
  if (!entry) return false;
  return resolve(entry) === fileURLToPath(import.meta.url);
}

if (isDirectRun()) {
  const ref = extractReference();
  mkdirSync(dirname(JSON_OUT), { recursive: true });
  writeFileSync(JSON_OUT, `${JSON.stringify(ref, null, 2)}\n`);
  writeFileSync(MD_OUT, renderMarkdown(ref));
  const counts = ref.settings_keys.tab_counts;
  console.log(`Wrote ${JSON_OUT}`);
  console.log(`Wrote ${MD_OUT}`);
  console.log(`keys=${ref.settings_keys.static_key_count} factory=${ref.settings_keys.factory_key_count} app=${counts.app} mcf=${counts.mcf_algorithm} iq=${counts.iq} features=${ref.ctwo.app_features.count}`);
}
