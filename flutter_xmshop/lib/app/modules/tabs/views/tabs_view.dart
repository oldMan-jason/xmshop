import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tabs_controller.dart';

class TabsView extends GetView<TabsController> {
  const TabsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: PageView(
          // 禁止pageView左右滑动
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          children: controller.pages,
          onPageChanged: (value) {
            controller.tabItemSelectIndex.value = value;
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              controller.pageController.jumpToPage(index);
              controller.tabItemSelectIndex.value = index;
            },
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.tabItemSelectIndex.value,
            fixedColor: Colors.amber,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "首页",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: "分类",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.medical_services),
                label: "服务",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shop),
                label: "购物车",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: "我的",
              )
            ]),
      );
    });
    ;
  }
}
