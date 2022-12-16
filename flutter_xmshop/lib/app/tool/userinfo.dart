import 'package:flutter_xmshop/app/tool/cachetool.dart';

class UserInfo {
  static Future<List> getUserInfo() async {
    List? userInfo = await CacheTool.getObject("userInfoKey");
    if (userInfo != null) {
      return userInfo;
    } else {
      return [];
    }
  }

  static Future<bool> getUserLoginState() async {
    List userInfo = await getUserInfo();
    if (userInfo.isNotEmpty && userInfo[0]["username"] != "") {
      return true;
    } else {
      return false;
    }
  }

  // 退出登录
  static Future removeUserInfoData() async {
    await CacheTool.removeObject("userInfoKey");
  }
}

// 封装的提示信息model
class MessageInfo {
  String? message;
  bool states;
  MessageInfo(this.message, this.states);
}
