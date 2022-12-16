import 'package:flutter/material.dart';
import 'package:flutter_xmshop/app/tool/httpclient.dart';
import 'package:flutter_xmshop/app/tool/userinfo.dart';
import 'package:get/get.dart';
import '../../../../tool/cachetool.dart';

class RegisteroffController extends GetxController {
  final HttpClient httpClient = HttpClient();
  final TextEditingController passtextEditingController =
      TextEditingController();
  final TextEditingController confirmtextEditingController =
      TextEditingController();

  var tel = Get.arguments["tel"];
  var code = Get.arguments["code"];

  @override
  void onInit() {
    super.onInit();
  }

  // 完成注册
  Future<MessageInfo> completeRegister(String pwd) async {
    var response = await httpClient.post("api/register", data: {
      "tel": tel,
      "password": pwd,
      "code": code,
    });

    if (response.data != null) {
      CacheTool.saveObject("userInfoKey", response.data["userinfo"]);
    }
    return MessageInfo(response.data["message"], response.data["success"]);
  }
}
