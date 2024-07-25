export interface LoginRequest {
  username: string,
  password: string,
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
  unident: string,
  tmdbid: string,
  filters: string,
  media_type: string,
  token: string,
}

export interface recommendRequest {
  type: string,
  subtype: string,
  page: string,
}