import { recommend, search } from '../http/httpServe';
import router from '@ohos.router'
import { LoginResponse } from '../http/httpItem';

@Entry
@Component
struct SearchPage {
  @State submitValue: string = '';
  controller: SearchController = new SearchController()
  @State login: LoginResponse = router.getParams() as LoginResponse;

  aboutToAppear(): void {
    console.log('params =' + JSON.stringify(this.login));
    this.recommend()
  }

  build() {
    Column() {
      Search({ placeholder: '请输入搜索内容...', controller: this.controller })
        .searchButton('搜索')
        .onSubmit((value: string) => {
          this.submitValue = value
          this.search()
        })
    }
    .width('100%')
    .padding({ left: 12, right: 12, top: 20 })
  }

  async search() {
    await search('沉默', this.login.token)
  }

  async recommend() {
    await recommend(this.login.userinfo.userpris[0])
  }
}