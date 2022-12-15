import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../controllers/code_controller.dart';

class CodeView extends GetView<CodeController> {
  const CodeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('手机号快速登录'),
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
                text: "+86 158****6398",
                style: TextStyle(fontSize: 13, color: Colors.black)),
          ])),
          SizedBox(
            height: 30,
          ),
          // 验证码
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: PinCodeTextField(
              length: 6,
              // autoFocus: true,
              keyboardType: TextInputType.number,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
              ),
              animationDuration: Duration(milliseconds: 300),
              backgroundColor: Colors.blue.shade50,
              enableActiveFill: true,
              controller: controller.textEditingController,
              onCompleted: (v) {
                print("Completed");
              },
              onChanged: (value) {
                print(value);
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                return true;
              },
              appContext: context,
            ),
          ),

          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "重新发送(44)",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 122, 117, 117)),
                    )),
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
          )
        ],
      ),
    );
  }
}
