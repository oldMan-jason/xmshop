import 'dart:async';

import 'package:get/get.dart';
import '../../../tool/httpclient.dart';
import '../models/product_model.dart';
import 'package:flutter/material.dart';

/**
 *  商品列表
 */
class ProductlistController extends GetxController {
  late ScrollController scrollController = ScrollController();
  int pageNumber = 1;
  bool isRequest = true;
  RxBool hasData = true.obs;
  late HttpClient httpClient = HttpClient();
  RxList<PlistItemModel> listData = <PlistItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
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

  headerRefresh() {
    pageNumber = 1;
    hasData.value = true;
    _loadListData();
  }

  _loadListData() async {
    if (isRequest && hasData.value) {
      isRequest = false;
      var argu = {"cid": Get.arguments, "page": pageNumber, "pageSize": 10};
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
