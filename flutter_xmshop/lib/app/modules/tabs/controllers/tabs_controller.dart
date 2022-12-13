import 'package:flutter/material.dart';
import 'package:flutter_xmshop/app/modules/cart/views/cart_view.dart';
import 'package:flutter_xmshop/app/modules/category/views/category_view.dart';
import 'package:flutter_xmshop/app/modules/home/views/home_view.dart';
import 'package:flutter_xmshop/app/modules/service/views/service_view.dart';
import 'package:flutter_xmshop/app/modules/user/views/user_view.dart';
import 'package:get/get.dart';

///  控制tabsview的逻辑
class TabsController extends GetxController {
  // item点击索引
  var tabItemSelectIndex = 3.obs;

  // 页面滚动缓存，在pageview 和tabView中才被使用
  late PageController pageController =
      PageController(initialPage: tabItemSelectIndex.value);

  List<Widget> pages = const [
    HomeView(),
    CategoryView(),
    ServiceView(),
    CartView(),
    UserView()
  ];
}
