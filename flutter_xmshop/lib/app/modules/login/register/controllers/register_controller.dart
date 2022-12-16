import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../tool/httpclient.dart';

class RegisterController extends GetxController {
  final HttpClient httpClient = HttpClient();
  final TextEditingController textEditingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  // 获取验证码
  Future<Map?> loadCode(String tel) async {
    var response = await httpClient.post("api/sendCode", data: {"tel": tel});
    if (response.data != null) {
      return response.data;
    }
    return null;
  }
}
