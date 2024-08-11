import { recommend, search, searchResult } from '../http/httpServe';
import router from '@ohos.router'
import { LoginResponse, Recommend } from '../http/httpItem';
import { promptAction } from '@kit.ArkUI';
import RecommendItem from '../component/RecommendItem';

@Entry
@Component
struct SearchPage {
  @State submitValue: string = '鬼灭之刃';
  controller: SearchController = new SearchController()
  @State login: LoginResponse = router.getParams() as LoginResponse;
  @State recommendList: Recommend[] = [];

  aboutToAppear(): void {
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
      Row() {
        Text('推荐列表')
        Text('推荐类型')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      List({ space: 10 }) {
        ForEach(this.recommendList, (item: Recommend,) => {
          ListItem() {
            RecommendItem({ item: item })
          }
        }, (item: Recommend) => JSON.stringify(item))
      }.margin({ top: 8 })
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
      if (response.code == 0 && response.success) {
        this.searchResult()
      }
    } catch (error) {
      this.toastShow('搜索失败!')
    }
  }

  async searchResult() {
    await searchResult()
    // const response = await searchResult()
    // console.debug('TAG', 'searchResult response = ' + JSON.stringify(response));
  }

  async recommend() {
    const response = await recommend('MOV', 'hm')
    if (response.code === 0 && response.success) {
      this.recommendList = response.data.Items
    }
  }
}