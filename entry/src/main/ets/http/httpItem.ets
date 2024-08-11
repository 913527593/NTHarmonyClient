export interface LoginRequest {
  username: string,
  password: string,
}

export interface BaseResponse<T> {
  code: number,
  success: boolean,
  message: string
  data: T
}

export interface LoginResponse {
  token: string,
  apikey: string,
  userinfo: UserInfo
}

export interface UserInfo {
  userid: number,
  username: string,
  userpris: string[]
}

export interface SearchRequest {
  search_word: string,
  unident?: string,
  tmdbid?: string,
  filters?: string,
  media_type?: string,
}

export interface SearchResponse {
  total: number,
  result: SearchResult
}

export interface SearchResult {}


export interface RecommendRequest {
  type: string,
  subtype: string,
  // keyword:string,
  // source:string
  page: string,
}

export interface RecommendResponse {
  Items: Recommend[]
}

export interface Recommend {
  id: number,
  orgid: number,
  tmdbid: number,
  title: string,
  type: string,
  media_type: string,
  year: string,
  vote: number[],
  image: string,
  overview: string,
  fav: string,
  rssid: string,
}