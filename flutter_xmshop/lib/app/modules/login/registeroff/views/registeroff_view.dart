import 'package:flutter/material.dart';
import 'package:flutter_xmshop/app/tool/userinfo.dart';

import 'package:get/get.dart';

import '../controllers/registeroff_controller.dart';

InputBorder _inputBorder() {
  return OutlineInputBorder(
      borderSide: BorderSide(width: 0, color: Colors.transparent));
}

/**
 *  最后一步完成注册
 */
class RegisteroffView extends GetView<RegisteroffController> {
  const RegisteroffView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('完成注册'),
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
                controller: controller.passtextEditingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    // 清楚按钮
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.cancel, color: Colors.grey)),
                    hintText: "请输入密码",
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

            Container(
              alignment: Alignment.center,
              height: 54,
              margin: EdgeInsets.fromLTRB(20, 10, 20, 40),
              padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 239, 231, 231),
                  borderRadius: BorderRadius.circular(20)),
              child: TextField(
                controller: controller.confirmtextEditingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    // 清楚按钮
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.cancel, color: Colors.grey)),
                    hintText: "请确认输入密码",
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

            // 完成注册
            InkWell(
              onTap: () async {
                if (controller.passtextEditingController.text ==
                    controller.confirmtextEditingController.text) {
                  MessageInfo messageInfo = await controller.completeRegister(
                      controller.passtextEditingController.text);
                  if (messageInfo.states) {
                    // Get.offAllNamed("/tabs");
                    Get.back();
                  } else {
                    Get.snackbar("提示", "注册失败");
                  }
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
                  "完成注册",
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
