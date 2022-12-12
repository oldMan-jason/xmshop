import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../tool/httpclient.dart';
import '../models/pcontent.dart';

class ProductdetailController extends GetxController {
  GlobalKey globalKey1 = GlobalKey();
  GlobalKey globalKey2 = GlobalKey();
  GlobalKey globalKey3 = GlobalKey();

  late HttpClient httpClient = HttpClient();
  // 自定义响应式model
  var item = PcontentItemModel().obs;
  RxList<PcontentAttrModel> attModel = <PcontentAttrModel>[].obs;

  RxDouble op = 0.0.obs;
  //是否显示tabs
  RxBool showTabs = false.obs;
  RxInt selectId = 1.obs;
  late ScrollController scrollController = ScrollController();
  List tabsList = [
    {
      "id": 1,
      "title": "商品",
    },
    {"id": 2, "title": "详情"},
    {"id": 3, "title": "推荐"}
  ];
  @override
  void onInit() {
    super.onInit();
    _loadData();
    scrollController.addListener(() {
      if (scrollController.position.pixels < 0) {
        showTabs.value = false;
        op.value = 0.0;
        update();
        return;
      }

      if (scrollController.position.pixels <= 100) {
        op.value = scrollController.position.pixels / 100;
        if (showTabs.value == true) {
          showTabs.value = false;
        }
        update();
      } else {
        if (showTabs.value == false) {
          showTabs.value = true;
          update();
        }
      }
    });
  }

// https://xiaomi.itying.com/api/pcontent?id=6332bc60a3a7080ac06eaee8
  changeNavIndex(id) {
    selectId.value = id;
    //跳转到指定的容器
    if (id == 1) {
      Scrollable.ensureVisible(globalKey1.currentContext as BuildContext,
          duration: const Duration(milliseconds: 100));
    } else if (id == 2) {
      Scrollable.ensureVisible(globalKey2.currentContext as BuildContext,
          duration: const Duration(milliseconds: 100));
    } else {
      Scrollable.ensureVisible(globalKey3.currentContext as BuildContext,
          duration: const Duration(milliseconds: 500));
    }

    update();
  }

  updateSheetFlag1(title) {
    List tl = [];
    var firstlist = attModel.first.list;
    for (var model in firstlist!) {
      print(model.title);
      if (model.title == title) {
        model.choose = true;
      } else {
        model.choose = false;
      }
    }
    update();
  }

  updateSheetFlag2(title) {
    var lastlist = attModel.last.list;
    for (var model in lastlist!) {
      print(model.title);
      if (model.title == title) {
        model.choose = true;
      } else {
        model.choose = false;
      }
    }
    update();
  }

  // 获取详情数据
  _loadData() async {
    var response = await httpClient
        .get("api/pcontent", arguments: {"id": "${Get.arguments["cid"]}"});
    print(response.data);
    item.value = PcontentModel.fromJson(response.data).result!;
    attModel.addAll(item.value.attr!);
    update();
  }
}
