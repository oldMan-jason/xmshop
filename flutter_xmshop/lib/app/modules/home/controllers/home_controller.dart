import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../models/focus_model.dart';
import '../models/cate_model.dart';

class HomeController extends GetxController {
  late ScrollController scrollController = ScrollController();
  RxBool changeFlag = true.obs;
  bool iswhite = false;
  RxList<FocusItemModel> bannerDataList = <FocusItemModel>[].obs;
  RxList<CateItemModel> cateDataList = <CateItemModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    _addListener();
    _loadBannerData();
    _loadCateData();
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
    Map<String, dynamic> map = response.data;
    // 模型化
    bannerDataList.value = FocusModel.fromJson(map).result!;
    update();
  }

  //加载分类数据
  _loadCateData() async {
    var response = await Dio().get("https://xiaomi.itying.com/api/bestCate");
    Map<String, dynamic> map = response.data;
    cateDataList.value = CateModel.fromJson(map).result!;
    // print(cateDataList.value);
    update();
  }
}
