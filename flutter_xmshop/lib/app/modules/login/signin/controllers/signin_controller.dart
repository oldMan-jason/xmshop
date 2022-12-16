import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../tool/httpclient.dart';

class SigninController extends GetxController {
  final HttpClient httpClient = HttpClient();
  final TextEditingController textEditingController = TextEditingController();

  // 获取验证码
  Future<Map?> loadCode(String tel) async {
    var response =
        await httpClient.post("api/sendLoginCode", data: {"tel": tel});
    if (response.data != null) {
      return response.data;
    }
    return null;
  }
}
