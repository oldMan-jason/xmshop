import 'package:flutter_xmshop/app/tool/userinfo.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  RxBool loginState = false.obs;
  Rx<UserModel> user = UserModel().obs;
  @override
  void onInit() {
    super.onInit();
    getuserInfo();
  }

  getuserInfo() async {
    bool state = await UserInfo.getUserLoginState();
    loginState.value = state;
    var tmp = await UserInfo.getUserInfo();
    user.value = UserModel.fromJson(tmp[0]);
    update();
  }

  // 退出登录
  loginOut() {
    UserInfo.removeUserInfoData();
    loginState.value = false;
    user.value = UserModel();
    update();
  }
}
