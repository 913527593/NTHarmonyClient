import { Recommend } from '../http/httpItem'

@Component
export default struct RecommendItem {
  @Prop item: Recommend

  build() {
    Row() {
      Stack({ alignContent: Alignment.Bottom }) {
        Image(this.item.image)
          .id('item_logo')
          .width('100%')
          .height('100%')
          .borderRadius(12)
        Row() {
          Image($r('app.media.search'))
            .width(20)
            .height(20)
          Image($r('app.media.heart'))
            .width(20)
            .height(20)
        }
        .width('90%')
        .margin({ bottom: 8 })
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width(80)
      .height(120)

      Column() {
        Text(this.item.title)
          .fontSize(16)
          .fontWeight(FontWeight.Regular)

        Row() {
          Text(this.item.media_type)
            .textStyler()
          Text(this.item.year)
            .opacity(0.8)
            .textStyler()
            .margin({left:8})
        }
        .margin({ top: 4 })

        Blank()
        Text(this.item.overview)
          .opacity(0.6)
          .fontSize(14)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(3)
      }
      .height('100%')
      .layoutWeight(1)
      .margin({ right: 12, left: 12 })
      .padding({ top: 6, bottom: 6 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(120)
  }

}

@Extend(Text)
function textStyler() {
  .width('auto')
  .fontSize(12)
  .fontColor(Color.White)
  .padding({ left: 6, right: 6, top: 2, bottom: 2 })
  .borderRadius(9)
  .backgroundColor(Color.Green)
}


