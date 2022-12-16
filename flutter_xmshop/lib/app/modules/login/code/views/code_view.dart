import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../tool/userinfo.dart';
import '../controllers/code_controller.dart';

class CodeView extends GetView<CodeController> {
  const CodeView({Key? key}) : super(key: key);

  // 完成注册页面
  void jumpToRegisterOff() {
    if (controller.isloginSource) {
      // 验证码登录
      Get.offAllNamed("/tabs");
    } else {
      //注册获取验证码
      Get.toNamed("/registeroff",
          arguments: {"tel": controller.tel, "code": controller.code});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('${Get.arguments["title"]}'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Image.asset("assets/images/logo.png"),
          SizedBox(
            height: 40,
          ),
          Text("请输入验证码"),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "已发送至",
                style: TextStyle(fontSize: 13, color: Colors.black38)),
            TextSpan(
                text: "+86 ${Get.arguments["mobile"]}",
                style: TextStyle(fontSize: 13, color: Colors.black)),
          ])),
          SizedBox(
            height: 30,
          ),
          // 验证码
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: PinCodeTextField(
              autoFocus: true, //进入就弹出键盘
              keyboardType: TextInputType.number, //调用数字键盘
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              dialogConfig: DialogConfig(
                  //汉化dialog
                  dialogTitle: "黏贴验证码",
                  dialogContent: "确定要黏贴验证码",
                  affirmativeText: "确定",
                  negativeText: "取消"), //配置dialog
              pinTheme: PinTheme(
                //样式
                // 修改边框
                activeColor: Colors.black12, // 输入文字后边框的颜色
                selectedColor: Colors.orange, // 选中边框的颜色
                inactiveColor: Colors.black12, //默认的边框颜色
                //背景颜色
                activeFillColor: Colors.white,
                selectedFillColor: Colors.orange,
                inactiveFillColor: const Color.fromRGBO(245, 245, 245, 1),

                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
              ),
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              controller: controller.textEditingController, //TextFiled控制器
              onCompleted: (v) async {
                MessageInfo messageInfo = controller.isloginSource
                    ? await controller.validateLoginCode()
                    : await controller.validateCode();
                if (!messageInfo.states) {
                  Get.snackbar("提示信息!", "验证码输入错误");
                } else {
                  Get.snackbar("提示信息!", "验证码验证成功");
                  jumpToRegisterOff();
                }
              },
              onChanged: (value) {
                print(value);
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                return true;
              },
              appContext: context, //注意需要传入context
            ),
          ),

          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: () {
                  controller.startTimer();
                }, child: Obx(() {
                  return Text(
                    "重新发送(${controller.count.value})",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 122, 117, 117)),
                  );
                })),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "获取帮助",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 38, 105, 159)),
                    )),
              ],
            ),
          ),
          // 验证
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(20),
            height: 58,
            decoration: BoxDecoration(
                color: Colors.red[300],
                borderRadius: BorderRadius.circular(20)),
            child: TextButton(
                onPressed: () async {
                  MessageInfo messageInfo = await controller.isloginSource
                      ? controller.validateLoginCode()
                      : controller.validateCode();
                  if (!messageInfo.states) {
                    Get.snackbar("提示信息!", "验证码输入错误");
                  } else {
                    Get.snackbar("提示信息!", "验证成功");
                    jumpToRegisterOff();
                  }
                  // 收起键盘
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Text(
                  "验证",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
          )
        ],
      ),
    );
  }
}
