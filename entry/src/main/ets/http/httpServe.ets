import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'
import { LoginRequest, LoginResponse } from './httpItem';
import { loginUrl } from './httpUrl'

const instance = axios.create({
  headers: {
    accept: 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded'
  },
});
instance.interceptors.request.use((config: InternalAxiosRequestConfig) => {
  console.debug('net test', 'interceptors.request url=' + config.url +
    ' ,data=' + JSON.stringify(config.data) + '\n,head =' + JSON.stringify(config.headers));
  // config.
  return config;
}, (error: AxiosError) => {
  // 对请求错误做些什么
  return Promise.reject(error);
})

/**
 *
 * @param name
 * @param pass
 */
async function login(name: string, pass: string): Promise<LoginResponse> {
  let req: LoginRequest = { username: name, password: pass }
  return new Promise((resolve, reject) => {
    instance.post(loginUrl, req)
      .then((response: AxiosResponse) => {
        console.debug('net test', 'response = ' + response.status);
        if (response.status === 200) {
          resolve(response.data.data)
        } else {
          reject(new Error(response.status + ',' + response.statusText))
        }
      }).catch((error: Error) => {
      console.error(error.message)
      reject(error)
    })
  })
}

export default login