// export const baseUrl = 'http://localhost:3000'
const baseUrl = 'http:/172.20.10.6:3000'

/**
 * 登录
 */
const loginUrl = baseUrl + '/api/v1/user/login'

/**
 *搜索
 */
const searchUrl = baseUrl + '/api/v1/search/keyword'

/**
 *
 */
const searchResultUrl = baseUrl + '/api/v1/search/result'

/**
 *推荐
 */
const recommendUrl = baseUrl + '/api/v1/recommend/list'


export { loginUrl, searchUrl, searchResultUrl, recommendUrl }