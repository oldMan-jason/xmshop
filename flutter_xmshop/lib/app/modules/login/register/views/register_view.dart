import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

InputBorder _inputBorder() {
  return OutlineInputBorder(
      borderSide: BorderSide(width: 0, color: Colors.transparent));
}

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('手机号快速注册'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Image.asset("assets/images/logo.png"),
            SizedBox(
              height: 40,
            ),
            Container(
              alignment: Alignment.center,
              height: 54,
              margin: EdgeInsets.fromLTRB(20, 30, 20, 10),
              padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 239, 231, 231),
                  borderRadius: BorderRadius.circular(20)),
              child: TextField(
                controller: controller.textEditingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    // 清楚按钮
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.cancel, color: Colors.grey)),
                    hintText: "请输入手机号",
                    contentPadding: EdgeInsets.all(0),
                    border: _inputBorder(),
                    disabledBorder: _inputBorder(),
                    errorBorder: _inputBorder(),
                    focusedBorder: _inputBorder(),
                    enabledBorder: _inputBorder(),
                    focusedErrorBorder: _inputBorder(),
                    hintStyle: TextStyle(fontSize: 18, color: Colors.black87)),
              ),
            ),

            // 下一步
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
                    Get.offAndToNamed("/code", arguments: {
                      "mobile": phone,
                      "title": "手机号快速注册",
                      "code": data["code"]
                    });
                  } else {
                    Get.snackbar("提示", "获取失败！");
                  }
                  FocusScope.of(context).requestFocus(FocusNode());
                } else {
                  Get.snackbar("提示", "手机号有误！");
                }
              },
              child: Container(
                height: 54,
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 171, 84, 78),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "下一步",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
