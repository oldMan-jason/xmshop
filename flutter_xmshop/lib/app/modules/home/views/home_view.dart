import 'package:flutter/material.dart';
import 'package:flutter_xmshop/app/tool/screenadapter.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../tool/cachepagestatewrapper.dart';
import '../../../customview/homeappbar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // 页面缓存，解决滚动切换tab后，定位重置问题
    return CachePageStateWrapperTool(
      keepAlive: true,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: -50,
              left: 0,
              right: 0,
              bottom: 0,
              child: ListView.builder(
                  // 绑定controller，监听滚动偏移量
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        width: ScreenAdpater.getScreenWidth(),
                        height: ScreenAdpater.height(682),
                        color: Colors.grey,
                        child: Image.network(
                          "https://www.itying.com/images/focus/focus02.png",
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                    return ListTile(
                      title: Text("$index"),
                    );
                  }),
            ),
            Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Obx(() {
                  return HomeAppBar(controller: controller).getAppBar();
                }))
          ],
        ),
      ),
    );
  }
}
