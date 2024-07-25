import { promptAction } from '@kit.ArkUI';
import { login } from '../http/httpServe';
import router from '@ohos.router'
import { LoginResponse } from '../http/httpItem';

@Entry
@Component
struct LoginPage {
  @State service: string = '';
  @State name: string = 'admin';
  @State pass: string = 'password';

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
        .margin({ bottom: 16 })

        Row() {
          Image($r('app.media.icon'))
            .imgStyle()
          TextInput({ placeholder: '请输入服务区地址', text: this.service })
            .type(InputType.Normal)
            .inputStyle()
            .onChange((value: string) => {
              this.service = value
            })
        }
        .rowStyle()

        Row() {
          Image($r('app.media.icon'))
            .imgStyle()
          TextInput({ placeholder: '请输入用户名', text: this.name })
            .type(InputType.Normal)
            .inputStyle()
            .onChange((value: string) => {
              this.name = value
            })
        }
        .rowStyle()
        .margin({ top: 18, bottom: 18 })

        Row() {
          Image($r('app.media.icon'))
            .imgStyle()
          TextInput({ placeholder: '请输入密码', text: this.pass })
            .type(InputType.Password)
            .inputStyle()
            .onChange((value: string) => {
              this.pass = value
            })
        }
        .rowStyle()

        Button('登录')
          .width('100%')
          .margin({ top: 24 })
          .onClick(() => this.buttonClick())
      }
      .width('80%')
      .height('auto')
      .margin({ top: '40%' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#fff3f1f1')
  }

  buttonClick() {
    // if (this.isEmpty(this.service) || this.isEmpty(this.name) || this.isEmpty(this.pass)) {
    if (this.isEmpty(this.name) || this.isEmpty(this.pass)) {
      this.toastShow('内容为空!')
      return
    }
    this.login()
  }

  login = async () => {
    try {
      const data = await login(this.name, this.pass)
      console.debug('net test', 'login response = ' + JSON.stringify(data));
      this.gotoSearch(data)
    } catch (error) {
      this.toastShow('登录失败!')
    }
  }

  gotoSearch(data: LoginResponse) {
    router.pushUrl({
      url: 'pages/SearchPage',
      params: data
    })
  }

  isEmpty = (key: string) => {
    return !Boolean(key)
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