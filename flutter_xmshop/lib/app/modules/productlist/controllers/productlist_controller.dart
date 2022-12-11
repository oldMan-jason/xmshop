import 'dart:async';

import 'package:get/get.dart';
import '../../../tool/httpclient.dart';
import '../models/product_model.dart';
import 'package:flutter/material.dart';

/**
 *  商品列表
 */
class ProductlistController extends GetxController {
  GlobalKey<ScaffoldState> globalKey = GlobalKey();
  late ScrollController scrollController = ScrollController();
  int pageNumber = 1;
  bool isRequest = true;
  RxBool hasData = true.obs;
  late HttpClient httpClient = HttpClient();
  RxList<PlistItemModel> listData = <PlistItemModel>[].obs;
  RxInt sort = 0.obs;
  String sortParma = "";
  RxInt arrow = 1.obs;
  String? searchValue;

  /*二级导航数据*/
  List subHeaderList = [
    {
      "id": 1,
      "title": "综合",
      "fileds": "all",
      "sort":
          -1, // 排序     升序：price_1     {price:1}        降序：price_-1   {price:-1}
    },
    {"id": 2, "title": "销量", "fileds": 'salecount', "sort": -1},
    {"id": 3, "title": "价格", "fileds": 'price', "sort": -1},
    {"id": 4, "title": "筛选"}
  ];

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is Map) {
      searchValue = Get.arguments["keyWord"];
    }

    _addListen();
    _loadListData();
  }

  _addListen() {
    scrollController.addListener(() {
      // 页面高度
      // scrollController.position.maxScrollExtent
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent - 30) {
        _loadListData();
      }
    });
  }

  // 筛选切换
  chanageOptions(id) {
    sort.value = id;
    if (id == 4) {
      globalKey.currentState!.openEndDrawer();
      return;
    } else {
      sortParma =
          "${subHeaderList[id - 1]["fileds"]}_${subHeaderList[id - 1]["sort"]}";
      arrow.value = arrow.value * -1;
      print("awwrorr -- ${arrow.value}");
    }

    //重置
    listData.value = [];
    headerRefresh();
    update();
  }

  headerRefresh() {
    pageNumber = 1;
    hasData.value = true;
    _loadListData();
  }

  _loadListData() async {
    if (isRequest && hasData.value) {
      isRequest = false;
      Map<String, dynamic> argu;
      if (searchValue != null) {
        argu = {
          "search": Get.arguments["keyWord"],
          "sort": sortParma,
          "page": pageNumber,
          "pageSize": 10
        };
      } else {
        argu = {
          "cid": Get.arguments,
          "sort": sortParma,
          "page": pageNumber,
          "pageSize": 10
        };
      }

      var response = await httpClient.get("api/plist", arguments: argu);
      print("参数 -- $argu");
      if (response.data != null) {
        var result = PlistModel.fromJson(response.data).result!;
        listData.addAll(result);
        if (result.length < 10) {
          hasData.value = false;
        }
        pageNumber++;
        update();

        Timer.periodic(const Duration(milliseconds: 800), (timer) {
          isRequest = true;
          timer.cancel();
        });
      }
    }
  }
}
