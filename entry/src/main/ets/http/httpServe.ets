import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'
import { getTokenSync } from '../util/Preferences';
import { LoginRequest, LoginResponse, recommendRequest, SearchRequest, SearchResponse } from './httpItem';
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
  if (config.url === searchUrl || config.url === recommendUrl) {
    //从首选项中获取token
    const token = getTokenSync()
    config.headers.set('Authorization', token.toString())
    console.debug(TAG, 'interceptors.request head =' + JSON.stringify(config.headers));
  }
  return config;
}, (error: AxiosError) => {
  // 对请求错误做些什么
  return Promise.reject(error);
})

/**
 *登录接口
 */
export async function login(name: string, pass: string): Promise<LoginResponse> {
  const req: LoginRequest = { username: name, password: pass }
  return new Promise((resolve, reject) => {
    instance.post(loginUrl, req)
      .then((response: AxiosResponse) => {
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

/**
 * 搜索接口
 */
export async function search(keyword: string): Promise<SearchResponse> {
  const req: SearchRequest = {
    search_word: keyword,
    unident: '1',
    tmdbid: 'bef95c8db909b6b11179cc740ff8d532',
    filters: '',
    media_type: '',
  }
  return await instance.post(searchUrl, req)
    .then((response: AxiosResponse) => {
      console.debug(TAG, 'search response = ' + JSON.stringify(response.data));
      return Promise.resolve(response.data);
    })
    .catch((error: Error) => {
      console.error(TAG, 'search error = ' + error.message);
      return Promise.reject(error);
    })

}

/**
 * 推荐接口
 */
export async function recommend(type: string, subtype: string) {
  const req: recommendRequest = {
    type: type,
    subtype: subtype,
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