import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'
import { LoginRequest, LoginResponse, recommendRequest, SearchRequest } from './httpItem';
import { loginUrl, searchUrl, recommendUrl } from './httpUrl'

const TAG = 'net test'
const instance = axios.create({
  headers: {
    accept: 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded'
  },
});
instance.interceptors.request.use((config: InternalAxiosRequestConfig) => {
  console.debug(TAG, 'interceptors.request url=' + config.url +
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
export async function login(name: string, pass: string): Promise<LoginResponse> {
  const req: LoginRequest = { username: name, password: pass }
  return new Promise((resolve, reject) => {
    instance.post(loginUrl, req)
      .then((response: AxiosResponse) => {
        console.debug(TAG, 'response = ' + response.status);
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

export async function search(keyword: string, token: string) {
  const req: SearchRequest = {
    // search_word: keyword,
    search_word: '%E6%B2%89%E9%BB%98',
    unident: '1',
    tmdbid: 'bef95c8db909b6b11179cc740ff8d532',
    filters: '',
    media_type: '',
    token: token
  }
  await instance.post(searchUrl, req)
    .then((response: AxiosResponse) => {
      console.debug(TAG, 'search response = ' + JSON.stringify(response.data));
    })
    .catch((error: Error) => {
      console.error('net test', 'search error = ' + error.message);
      throw error
    })

}

export async function recommend(type: string) {
  const req: recommendRequest = {
    type: type,
    subtype: '',
    page: '1'
  }
  await instance.post(recommendUrl, req)
    .then((response: AxiosResponse) => {
      console.debug(TAG, 'recommend response = ' + JSON.stringify(response.data));
    })
    .catch((error: Error) => {
      console.error(TAG, 'recommend error = ' + error.message);
      throw error
    })

}