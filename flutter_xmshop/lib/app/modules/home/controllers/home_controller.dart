import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late ScrollController scrollController = ScrollController();
  RxBool changeFlag = true.obs;
  bool iswhite = false;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    //监听lsitView的滚动
    scrollController.addListener(() {
      if (scrollController.offset > 30 && !iswhite) {
        changeFlag.value = false;
        iswhite = true;
        update();
      }

      if (scrollController.offset < 30 && iswhite) {
        changeFlag.value = true;
        iswhite = false;
        update();
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
