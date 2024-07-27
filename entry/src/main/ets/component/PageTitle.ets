@Component
export default struct PageTitle {
  @Prop title: string = ""
  //是否显示返回按钮
  @Prop isShowBack: boolean = true;
  //点击回调
  back: () => void = () => {
  }

  build() {
    RelativeContainer() {
      if (this.isShowBack) {
        Image($r('app.media.icon_back'))
          .id('title_back')
          .width(30)
          .height(30)
          .margin({ left: 8 })
          .onClick(() => this.back())
          .alignRules({
            top: { anchor: "__container__", align: VerticalAlign.Top },
            bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
          })
      }
      Text(this.title)
        .id('title_name')
        .width('auto')
        .fontSize('20')
        .fontColor(Color.Black)
        .textAlign(TextAlign.Center)
        .margin({ left: 40, right: 40 })
        .alignRules({
          top: { anchor: "__container__", align: VerticalAlign.Top },
          left: { anchor: "__container__", align: HorizontalAlign.Start },
          bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
          right: { anchor: "__container__", align: HorizontalAlign.End }
        })
    }
    .width('100%')
    .height(56)
  }
}