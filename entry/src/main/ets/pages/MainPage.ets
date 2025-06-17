import router from '@ohos.router';
import prompt from '@ohos.promptAction';
@Extend(TextInput) function InputStyle(){
  .width('100%')
  .height(45)
  //.backgroundColor('#F1F3F5')
  .fontSize(25)
  .placeholderColor('#99182431')
  .margin({top:10})
  .padding({left:1})
}

@Extend(Line)function LineStyle(){
  .width("100%")
  .height(0.5)
  .backgroundColor(Color.Grey)
}



@Entry
@Component
struct Index{
  @State account:string =''
  @State password:string =''
  @State rpassword:string =''
  @State isCatch:boolean =false;
  @State isShowProgress:boolean =false
  private timeOutId = -1;



  build() {

    //根组件
    Column({space:10}){
      //logo载体
      Column(){
        Row(){
          Image($r('app.media.queshi'))
            .width(80)
            .height(70)
            .margin({top:20})

        }
        Row(){
          Text("注册界面")
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .margin({top:16})
        }
        Row(){
          Text("注册以登录")
            .fontSize(20)
            .fontWeight(400)
            .margin({top:12})
        }

      }
      .width("100%")
      .height("30%")
      .margin({top:10})
      //输入框载体
      Column(){
        Column({space:17}){
          TextInput({ placeholder:'账号'})
            .InputStyle()
            .maxLength(10)
            .type(InputType.Number)
            .onChange((value:string) =>{
              this.account =value
            })
          Line()
            .LineStyle()
          TextInput({ placeholder:'密码'})
            .InputStyle()
            .maxLength(8)
            .type(InputType.Password)
            .onChange((value:string) =>{
              this.password =value
            })
          Line()
            .LineStyle()
          TextInput({ placeholder:'确认密码'})
            .InputStyle()
            .maxLength(8)
            .type(InputType.Password)
            .onChange((value:string) =>{
              this.rpassword =value
            })
          Line()
            .LineStyle()
        }
        Row(){
          Row(){
            Text('发送短信验证码')
              .fontSize(16)
              .fontColor('#007DFF')
          }
          .width('50%')
          .justifyContent(FlexAlign.Start)
          Row(){
            Text('重置密码')
              .fontSize(16)
              .fontColor('#007DFF')
          }
          .width("50%")
          .justifyContent(FlexAlign.End)
        }
        .width("100%")
        .margin({top:10})

      }
      .width("100%")
      .height("50%")
      .margin({top:-60})

      if (this.isShowProgress){
        LoadingProgress()
          .margin({top:12})
          .backgroundColor(Color.White)
          .width(30)
          .height(30)
      }
      //登录方式载体
      Column(){
        Row(){
          Button('注册')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .width('60%')
            .onClick(() =>{
              //router.pushUrl({url:'pages/LoginPage'})
              //console.log('账号:'+this.account+'\t\t\t密码：'+this.password+'\t\t\t重密码：'+this.rpassword);
              if(this.account ==''||this.password==''||this.rpassword==''){
                prompt.showToast({
                  message:'注册信息不能为空，请重新输入'
                })
              }else {
                if(this.password!=this.rpassword){
                  prompt.showToast({
                    message:'注册信息填写不一致，请重新核对后输入'
                  })
                }else {
                  //console.log('账号:'+this.account+'\t\t\t密码：'+this.password+'\t\t\t重密码：'+this.rpassword)
                //router.pushUrl({url:'pages/LoginPage'})
                  this.isShowProgress =true
                  if(this.timeOutId === -1){
                    this.timeOutId =setTimeout(() =>{
                      prompt.showToast({
                        message:'注册成功！'
                      })
                      this.isShowProgress =false
                      this.timeOutId =-1
                      router.pushUrl({
                        url:'pages/LoginPage',
                      params:{
                          account:this.account,
                        password:this.password
                      }
                      })
                    },1000)
                  }
                  //router
                }
              }
            })

        }
        .margin({bottom:7})
        Row(){
          Text('登录')
            .fontSize(20)
            .fontWeight(400)
            .fontColor('#007DFF')
            .onClick(() =>{
              router.pushUrl({
                url:'pages/LoginPage',
                params:{
                  account:this.account,
                  password:this.password
                }
              })
            })
        }
        .width("30%")
        .justifyContent(FlexAlign.Center)
        Row(){
          Text('其他登录方式')
            .fontSize(14)
            .fontColor('#99182431')
            .fontWeight(400)
        }
        .margin({top:10})
        Row(){
          Button(){
            Image($r('app.media.wangyi'))
              .borderRadius(30)
              .width(48)
              .height(48)
              .backgroundColor('#F1F3F5')
          }
          Button(){
            Image($r('app.media.weixin'))
              .borderRadius(30)
              .width(48)
              .height(48)
              .backgroundColor('#F1F3F5')
          }
          Button(){
            Image($r('app.media.wenan3'))
              .borderRadius(30)
              .width(48)
              .height(48)
              .backgroundColor('#F1F3F5')
          }

        }
        .margin({top:7})
        .justifyContent(FlexAlign.SpaceAround)
        .width('100%')


      }
      .width("100%")
      .height("30%")
    }
    .width("100%")
    .height("100%")
    //.backgroundImage($r('app.media.beijing2'))
    .backgroundImageSize(100)
    //.backgroundColor('#F1f3f5')
    //.linearGradient({
      //angle:70,
      //colors:[
        //[0xF1f3f5,0.0],
        //[0xb9daeb,2.0]
      //]
    //})
    .expandSafeArea([SafeAreaType.SYSTEM])


  }
}
