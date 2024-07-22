import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct LoginPage {
  @State service: string = '';
  @State name: string = '';
  @State pass: string = '';

  build() {
    Column() {
      Column() {
        Row() {
          Image($r('app.media.icon'))
            .width(30)
            .margin({ right: 10 })

          Text('NasTools')
            .fontSize(20)
            .height('100%')
            .textAlign(TextAlign.Center)
        }
        .height(40)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .margin({ bottom: 16})

        Row() {
          Image($r('app.media.icon'))
            .imgStyle()
          TextInput({ placeholder: '请输入服务区地址', text: this.service })
            .type(InputType.Normal)
            .inputStyle()
        }
        .rowStyle()

        Row() {
          Image($r('app.media.icon'))
            .imgStyle()
          TextInput({ placeholder: '请输入用户名', text: this.name })
            .type(InputType.Normal)
            .inputStyle()
        }
        .rowStyle()
        .margin({ top: 10, bottom: 10 })

        Row() {
          Image($r('app.media.icon'))
            .imgStyle()
          TextInput({ placeholder: '请输入密码', text: this.pass })
            .type(InputType.Password)
            .inputStyle()
        }
        .rowStyle()

        Button('登录')
          .width('100%')
          .margin({ top: 20 })
          .onClick(() => this.buttonClick())
      }
      .width('80%')
      .height('auto')
      .margin({ top: '40%' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ffdddada')
  }

  buttonClick() {
    console.log('button click');
    if (this.isEmpty(this.service) || this.isEmpty(this.name) || this.isEmpty(this.pass)) {
      this.toastShow('内容为空!')
      return
    }
    //...
  }

  isEmpty = (key: string) => {
    return key === undefined || key === '' || key === null
  }
  toastShow = (key: string) => {
    promptAction.showToast({ message: key })
  }
}

@Extend(Image)
function imgStyle() {
  .width(20)
}

@Extend(TextInput)
function inputStyle() {
  .backgroundColor(Color.White)
  .layoutWeight(1)
}

@Extend(Row)
function rowStyle() {
  .width('100%')
  .height(50)
  .backgroundColor(Color.White)
  .borderRadius(25)
  .padding({ left: 16, right: 10 })
}