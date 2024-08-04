import PageTitle from '../component/PageTitle';
import router from '@ohos.router'

@Entry
@Component
struct SearchListPage {
  @State message: string = '鬼灭之刃';
  @State numbers: number[] = []
  @State isTouch: Boolean = false
  private gridScroller: Scroller = new Scroller()

  aboutToAppear() {
    for (let i = 0; i < 30; i++) {
      this.numbers.push(i)
    }
  }

  goBack() {
    console.log('SearchListPage back')
    router.back()
  }

  build() {
    Column() {
      PageTitle({ title: this.message, back: this.goBack })
      Grid(this.gridScroller) {
        ForEach(this.numbers, (item: number) => {
          GridItem() {
            Stack() {
              Image('https://image.tmdb.org/t/p/w500/uzwyc4iTg8SaEcFWQ4jegLPALZh.jpg')
                .width('100%')
                .height('100%')
                .borderRadius(8)
              if (this.isTouch) {
                Text('演员阵容：')
                  .width('100%')
                  .height('100%')
                  .fontSize(16)
                  .fontColor(Color.White)
                  .borderRadius(8)
                  .textAlign(TextAlign.Center)
              }
            }
          }
          .width('100%')
          .height(120)
          .onTouch((event) => {
            this.isTouch = event.type == TouchType.Down
          })
        }, (item: string) => item)
      }
      .columnsTemplate('1fr 1fr')
      // .friction(0.3)
      .columnsGap(8)
      .rowsGap(10)
      .scrollBar(BarState.Off)
      .margin({ left: 12, right: 12 })
    }
    .width('100%')
    .height('100%')
  }
}