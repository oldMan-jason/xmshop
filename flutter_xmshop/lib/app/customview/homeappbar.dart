import 'package:flutter/material.dart';
import '../modules/home/controllers/home_controller.dart';
import '../tool/customicon.dart';
import '../tool/screenadapter.dart';

class HomeAppBar extends AppBar {
  final HomeController controller;

  HomeAppBar({super.key, required this.controller});

  Widget getAppBar() {
    return AppBar(
      backgroundColor:
          controller.changeFlag.value ? Colors.transparent : Colors.green,
      elevation: 0, //去除阴影
      leading: Container(
        padding: const EdgeInsets.all(10),
        width: 100,
        height: 100,
        child: const Icon(
          CustomIcon.xiaomin,
          color: Colors.white, //设置图标颜色
        ),
      ),
      leadingWidth: controller.changeFlag.value
          ? ScreenAdpater.width(200)
          : ScreenAdpater.width(80),
      title: AnimatedContainer(
        duration: const Duration(seconds: 3),
        width: controller.changeFlag.value
            ? ScreenAdpater.width(620)
            : ScreenAdpater.width(820),
        height: ScreenAdpater.height(96),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(48)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Icon(
                Icons.search,
                size: 28,
                color: Colors.grey,
              ),
            ),
            Text(
              "请输入搜索内容...",
              style: TextStyle(
                  fontSize: ScreenAdpater.fontSize(38),
                  color: const Color.fromARGB(255, 131, 122, 122)),
            )
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(CustomIcon.qrCode),
          color: !controller.changeFlag.value ? Colors.black87 : Colors.white,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(CustomIcon.message),
          color: !controller.changeFlag.value ? Colors.black87 : Colors.white,
        )
      ],
    );
  }
}
