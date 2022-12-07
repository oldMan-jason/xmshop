import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class HomeController extends GetxController {
  late ScrollController scrollController = ScrollController();
  RxBool changeFlag = true.obs;
  bool iswhite = false;

  RxList bannerDataList = [].obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    _addListener();
    _loadBannerData();
  }

  //监听lsitView的滚动
  _addListener() {
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

  // 加载bannner数据
  _loadBannerData() async {
    var response = await Dio().get("https://xiaomi.itying.com/api/focus");
    bannerDataList.value = response.data["result"];
    print(response.data);
    update();
  }
}
