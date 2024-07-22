import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'
import loginUrl, { baseUrl } from './httpUrl'

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
});

interface request {
  username: string,
  password: string,
}

//
const login = async (name: string, pass: string) => {
  let req: request = { username: name, password: pass }
  // const response: AxiosResponse = await instance.post(baseUrl+loginUrl, req)
  await instance.post(baseUrl+loginUrl, req)
    .then((response: AxiosResponse<string>) => {
      console.debug('net test', 'response = ' + JSON.stringify(response));
    })
    .catch((error: Error) => {
      console.info(JSON.stringify(error));
      console.debug('net test', 'error =' + error.message);
    })
}

export default login