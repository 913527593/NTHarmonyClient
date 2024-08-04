import { recommend, search, searchResult } from '../http/httpServe';
import router from '@ohos.router'
import { LoginResponse } from '../http/httpItem';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct SearchPage {
  @State submitValue: string = '鬼灭之刃';
  controller: SearchController = new SearchController()
  @State login: LoginResponse = router.getParams() as LoginResponse;

  aboutToAppear(): void {
    console.log('params =' + JSON.stringify(this.login));
    this.recommend()
  }

  build() {
    Column() {
      Search({ value: this.submitValue, placeholder: '请输入搜索内容...', controller: this.controller })
        .searchButton('搜索')
        .onSubmit((value: string) => {
          this.submitValue = value
          this.search()
        })

      Text('search Result')
        .onClick(()=>{
          this.searchResult()
        })
    }
    .width('100%')
    .padding({ left: 12, right: 12, top: 20 })
  }

  toastShow = (key: string) => {
    promptAction.showToast({ message: key })
  }

  async search() {
    try {
      const response = await search(this.submitValue)
      console.debug('TAG', 'search response = ' + JSON.stringify(response));
      if (response.code == 0 && response.success) {
        //
        this.searchResult()
      }
    } catch (error) {
      this.toastShow('搜索失败!')
    }
  }

  async searchResult() {
    const response = await searchResult()
    console.debug('TAG', 'searchResult response = ' + JSON.stringify(response));
  }

  async recommend() {
    await recommend('探索', '榜单推荐')
  }
}