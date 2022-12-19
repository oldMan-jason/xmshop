import 'package:flutter/material.dart';
import 'package:flutter_xmshop/app/tool/screenadapter.dart';

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Container(
            width: 50,
            height: 30,
            child: TextButton(
                onPressed: () {},
                child: Text(
                  "帮助",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                )),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset("assets/images/logo.png"),
          SizedBox(
            height: 40,
          ),
          // 手机号
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            width: double.infinity,
            height: 68,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "+86",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                Container(
                  height: 68,
                  width: 300,
                  alignment: Alignment.center,
                  child: TextField(
                    controller: controller.textEditingController,
                    scrollPhysics: ScrollPhysics(),
                    decoration: InputDecoration(
                        constraints: BoxConstraints(),
                        hintText: "输入手机号",
                        hintStyle: TextStyle(fontSize: 20),
                        contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                        border: InputBorder.none),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 243, 234, 234),
                borderRadius: BorderRadius.circular(15)),
          ),

          SizedBox(
            height: 20,
          ),
          // 协议
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  iconSize: 20,
                  onPressed: () {},
                  icon: Icon(Icons.circle_outlined)),
              Container(
                width: ScreenAdpater.getScreenWidth() - 70,
                child: Text(
                  "阅读商城用户协议、商城用户隐私协议",
                  softWrap: true,
                  overflow: TextOverflow.clip,
                ),
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          // 获取验证码
          InkWell(
            onTap: () async {
              if (GetUtils.isPhoneNumber(
                      controller.textEditingController.text) &&
                  controller.textEditingController.text.length == 11) {
                var phone = controller.textEditingController.text;
                // 收起键盘
                FocusScope.of(context).requestFocus(FocusNode());
                Map? data = await controller.loadCode(phone);
                if (data != null) {
                  Get.snackbar("提示", data["message"]);
                  // 使用替换路由
                  Get.offAndToNamed("/code", arguments: {
                    "mobile": phone,
                    "title": "手机号快速登录",
                    "code": data["code"],
                    "sourcetype": 1
                  });
                } else {
                  Get.snackbar("提示", "获取失败！");
                }
              } else {
                Get.snackbar("提示", "手机号有误！");
              }
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              height: 54,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 212, 92, 104),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                "获取验证码",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Get.offAndToNamed(Routes.REGISTER);
                    },
                    child: Text(
                      "新用户注册",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    )),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "账户密码登录",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
