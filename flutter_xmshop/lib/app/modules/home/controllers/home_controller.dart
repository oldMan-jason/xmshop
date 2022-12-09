import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../models/focus_model.dart';
import '../models/cate_model.dart';
import '../models/hot_model.dart';
import '../models/stream_model.dart';
import '../../../tool/httpclient.dart';

class HomeController extends GetxController {
  late ScrollController scrollController = ScrollController();
  late HttpClient httpClient = HttpClient();

  RxBool changeFlag = true.obs;
  bool iswhite = false;
  RxList<FocusItemModel> bannerDataList = <FocusItemModel>[].obs;
  RxList<CateItemModel> cateDataList = <CateItemModel>[].obs;
  RxList<FocusItemModel> hotSellingDataList = <FocusItemModel>[].obs;
  RxList<HotItemModel> hotList = <HotItemModel>[].obs;
  RxList<SteamItemModel> streamList = <SteamItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _addListener();
    _loadBannerData();
    _loadCateData();
    _loadHotSellingBannerData();
    _loadHotSellingData();
    _loadStreamData();
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
    var response = await httpClient.get("api/focus");
    Map<String, dynamic> map = response.data;
    // 模型化
    bannerDataList.value = FocusModel.fromJson(map).result!;
    update();
  }

  //加载分类数据
  _loadCateData() async {
    var response = await httpClient.get("api/bestCate");
    Map<String, dynamic> map = response.data;
    cateDataList.value = CateModel.fromJson(map).result!;
    update();
  }

  // 臻选Banner
  _loadHotSellingBannerData() async {
    var response = await httpClient.get("api/focus?position=2");
    Map<String, dynamic> map = response.data;
    hotSellingDataList.value = FocusModel.fromJson(map).result!;
    update();
  }

  // 获取臻选推荐列表
  _loadHotSellingData() async {
    var response = await httpClient.get("api/plist?is_hot=1");
    Map<String, dynamic> map = response.data;
    hotList.value = Hotlist.fromJson(map).result;

    // hotList.asMap().entries.map((value) {
    //   value.key;
    //   value.value;
    //   return "";
    // });
    update();
  }

  //瀑布流数据
  _loadStreamData() async {
    var response = await httpClient.get("api/plist");
    Map<String, dynamic> map = response.data;
    streamList.value = StreamModel.fromJson(map).result;
    update();
  }
}
