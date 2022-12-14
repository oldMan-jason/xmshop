import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_xmshop/app/tool/screenadapter.dart';
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

  // 已选择的机型
  RxString choiceTypeValue = "".obs;
  RxInt buyNumber = 1.obs;

  // 导航条透明度
  RxDouble op = 0.0.obs;
  //是否显示tabs
  RxBool showTabs = false.obs;

  RxBool subHeaderShowFlag = false.obs;
  late ScrollController scrollController = ScrollController();

  // 一级浮动标题
  List tabsList = [
    {
      "id": 1,
      "title": "商品",
    },
    {"id": 2, "title": "详情"},
    {"id": 3, "title": "推荐"}
  ];

  // 二级浮动标题
  List subTabsList = [
    {
      "id": 1,
      "title": "商品介绍",
    },
    {"id": 2, "title": "规格参数"},
  ];
  RxInt selectSubTabsIndex = 1.obs;

  @override
  void onInit() {
    super.onInit();
    _loadData();
    _topNavBar();
  }

  // 顶部切换
  _topNavBar() {
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

  // 悬浮Header
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

  // 悬浮headerTab切换
  changeSubTabsIndex(id) {
    selectSubTabsIndex.value = id;
    update();
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
    var firstlist = attModel.first.list;
    for (var model in firstlist!) {
      if (model.title == title) {
        model.choose = true;
      } else {
        model.choose = false;
      }
    }
    update();
    _combineChoiceValue();
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
    _combineChoiceValue();
  }

  _combineChoiceValue() {
    var temp = attModel.map((element) {
      var result = element.list?.firstWhere((element) => element.choose);
      return result!.title;
    }).toList();
    var val = temp.join(",");
    choiceTypeValue.value = val;
  }

  incNumber() {
    buyNumber.value++;
    update();
  }

  decNumber() {
    if (buyNumber.value > 1) {
      buyNumber--;
      update();
    }
  }

  // 获取详情数据
  _loadData() async {
    var response = await httpClient
        .get("api/pcontent", arguments: {"id": "${Get.arguments["cid"]}"});
    item.value = PcontentModel.fromJson(response.data).result!;
    attModel.addAll(item.value.attr!);
    update();
  }
}
