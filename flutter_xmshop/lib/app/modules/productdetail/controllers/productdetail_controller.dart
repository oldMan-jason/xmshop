import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../tool/httpclient.dart';
import '../models/pcontent.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductdetailController extends GetxController {
  GlobalKey globalKey1 = GlobalKey();
  GlobalKey globalKey2 = GlobalKey();
  GlobalKey globalKey3 = GlobalKey();

  late HttpClient httpClient = HttpClient();
  // 自定义响应式model
  var item = PcontentItemModel().obs;
  // bottomSheet
  RxList<PcontentAttrModel> attModel = <PcontentAttrModel>[].obs;
  RxInt selectId = 1.obs;

  // 导航条透明度
  RxDouble op = 0.0.obs;
  //是否显示tabs
  RxBool showTabs = false.obs;

  RxBool subHeaderShowFlag = false.obs;

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
      _controllSubHeader();
      if (scrollController.position.pixels < 0) {
        showTabs.value = false;
        op.value = 0.0;
        update();
        return;
      }

      if (scrollController.position.pixels <= 100) {
        op.value = scrollController.position.pixels / 100;
        if (op.value > 0.9) {
          op.value = 1.0;
        }
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

  _controllSubHeader() {
    RenderBox box2 = globalKey2.currentContext!.findRenderObject() as RenderBox;
    double box2H = box2.localToGlobal(Offset.zero).dy;

    RenderBox box3 = globalKey3.currentContext!.findRenderObject() as RenderBox;
    double box3H = box3.localToGlobal(Offset.zero).dy;

    var h = MediaQuery.of(Get.context!).size.height * 0.06;
    var stateH = ScreenUtil().statusBarHeight;

    if (box2H < (stateH + h)) {
      if (!subHeaderShowFlag.value) {
        subHeaderShowFlag.value = true;
      }
    } else {
      if (subHeaderShowFlag.value) {
        subHeaderShowFlag.value = false;
      }
    }
    // print("box2 -- ${box2H}");
    // print("box3 -- ${box3H}");
    // print("scroll -- ${scrollController.offset}");
  }

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