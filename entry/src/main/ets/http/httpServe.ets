import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'
import { getTokenSync } from '../util/Preferences';
import {
  BaseResponse,
  LoginRequest,
  LoginResponse,
  RecommendRequest,
  RecommendResponse,
  SearchRequest,
  SearchResponse,
} from './httpItem';
import { loginUrl, searchUrl, recommendUrl, searchResultUrl } from './httpUrl'

const TAG = 'net test'
const instance = axios.create({
  headers: {
    accept: 'application/json',
    // 'Content-Type': 'application/x-www-form-urlencoded',
  },
  timeout: 60000,
});
instance.interceptors.request.use((config: InternalAxiosRequestConfig) => {
  if (config.url !== searchResultUrl) {
    config.headers.set('Content-Type', 'application/x-www-form-urlencoded')
  }
  if (config.url !== loginUrl) {
    //从首选项中获取token
    const token = getTokenSync()
    config.headers.set('Authorization', token.toString())
  }
  console.debug(TAG, 'interceptors.request url = ' + config.url + ' \n,head =' + JSON.stringify(config.headers) +
    ',data = ' + JSON.stringify(config.data));
  return config;
}, (error: AxiosError) => {
  // 对请求错误做些什么
  return Promise.reject(error);
});

instance.interceptors.response.use((response: AxiosResponse) => {
  console.debug(TAG, 'interceptors response = ' + JSON.stringify(response));
  return response
}, (error: AxiosError) => {
  console.error(TAG, 'interceptors response  error= ' + JSON.stringify(error));
  return Promise.reject(error);
})

/**
 *登录接口
 */
export async function login(name: string, pass: string): Promise<BaseResponse<LoginResponse>> {
  const req: LoginRequest = { username: name, password: pass }
  return new Promise((resolve, reject) => {
    instance.post(loginUrl, req)
      .then((response: AxiosResponse) => {
        if (response.status === 200) {
          resolve(response.data)
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
export async function search(keyword: string): Promise<BaseResponse<object>> {
  const req: SearchRequest = {
    search_word: keyword,
    unident: '1',
    tmdbid: '',
    filters: '',
    media_type: '',
  }
  return await instance.post(searchUrl, req)
    .then((response: AxiosResponse) => {
      return Promise.resolve(response.data);
    })
    .catch((error: Error) => {
      console.error(TAG, 'search error = ' + error.message);
      return Promise.reject(error);
    })

}

/**
 * 搜索接口返回数据接口
 * @returns
 */
export async function searchResult(): Promise<BaseResponse<SearchResponse>> {
  return await instance.post(searchResultUrl)
    .then((response: AxiosResponse) => {
      return Promise.resolve(response.data);
    })
    .catch((error: Error) => {
      return Promise.reject(error);
    })
}

/**
 * 推荐接口
 */
export async function recommend(type: string, subtype: string): Promise<BaseResponse<RecommendResponse>> {
  const req: RecommendRequest = {
    type: type,
    subtype: subtype,
    // keyword:'灭之刃',
    // source:'tmdb',
    page: '1'
  }
  return await instance.post(recommendUrl, req)
    .then((response: AxiosResponse) => {
      return Promise.resolve(response.data);
    })
    .catch((error: Error) => {
      return Promise.reject(error);
    })
}