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