import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_xmshop/app/tool/httpclient.dart';
import 'package:get/get.dart';

import '../../../../tool/cachetool.dart';
import '../../../../tool/userinfo.dart';
import '../../../user/controllers/user_controller.dart';

class CodeController extends GetxController {
  final TextEditingController textEditingController = TextEditingController();
  final UserController userController = Get.find<UserController>();
  final HttpClient httpClient = HttpClient();
  RxInt count = 10.obs;
  var tel = Get.arguments["mobile"];
  var code = Get.arguments["code"];
  bool isloginSource = Get.arguments["sourcetype"] == 1;

  // 定时器
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    userController.getuserInfo();
    if (timer != null && timer!.isActive) {
      timer?.cancel();
    }
    super.onClose();
  }

  startTimer() {
    if (timer != null && timer!.isActive) {
      return;
    }
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (count.value == 0) {
        count.value = 10;
        timer.cancel();
      } else {
        count.value--;
      }
      update();
    });

    isloginSource ? loadLoginCode : loadCode();
  }

  Future<MessageInfo> validateCode() async {
    var response = await httpClient
        .post("api/validateCode", data: {"tel": tel, "code": code});
    //测试：把验证码复制到剪切板上面，正式上线不需要这句话,这个为了方便测试
    Clipboard.setData(ClipboardData(text: code));
    return MessageInfo(response.data["message"], response.data["success"]);
  }

  // 获取验证码
  Future<Map?> loadCode() async {
    var response = await httpClient.post("api/sendCode", data: {"tel": tel});
    if (response.data != null) {
      return response.data;
    }
    return null;
  }

  // 获取登录验证码
  loadLoginCode() async {
    var response =
        await httpClient.post("api/sendLoginCode", data: {"tel": tel});
    if (response.data != null) {
      return response.data;
    }
    return null;
  }

  // 短信验证码登录验证
  validateLoginCode() async {
    var response = await httpClient
        .post("api/validateLoginCode", data: {"tel": tel, "code": code});
    if (response.data != null) {
      await CacheTool.saveObject("userInfoKey", response.data["userinfo"]);
    }
    return MessageInfo(response.data["message"], response.data["success"]);
  }
}
