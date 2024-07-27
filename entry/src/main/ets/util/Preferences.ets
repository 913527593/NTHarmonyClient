import { preferences } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';

const preferenceName = 'NaTool'
const keyToken = 'Token'
let dataPreferences: preferences.Preferences | null = null;

export function initPreferences(context: Context) {
  preferences.getPreferences(context, preferenceName, (err: BusinessError, val: preferences.Preferences) => {
    if (err) {
      console.error("Failed to get preferences. code =" + err.code + ", message =" + err.message);
      return;
    }
    dataPreferences = val;
    console.info("Succeeded in getting preferences.");
  })
}

export function getToken(defaultValue: string = ''): Promise<preferences.ValueType> {
  if (dataPreferences != null) {
    return dataPreferences?.get(keyToken, defaultValue)
  }
  return Promise.reject(new Error('get token error'))
}

export function getTokenSync(defaultValue: string = ''): preferences.ValueType {
  if (dataPreferences != null) {
    return dataPreferences?.getSync(keyToken, defaultValue)
  }
  return ''
}


export function setTokenSync(value: string) {
  dataPreferences?.putSync(keyToken, value)
}