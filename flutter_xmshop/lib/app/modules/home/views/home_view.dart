import 'package:flutter/material.dart';
import 'package:flutter_xmshop/app/modules/home/models/cate_model.dart';
import 'package:flutter_xmshop/app/modules/home/models/focus_model.dart';
import 'package:flutter_xmshop/app/tool/screenadapter.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../tool/cachepagestatewrapper.dart';
import '../../../customview/homeappbar.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import '../../../macro/macro.dart';

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
            _getBody(),
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

  //首页内容UI
  Widget _getBody() {
    return Positioned(
      top: -50,
      left: 0,
      right: 0,
      bottom: 0,
      child: ListView(
        controller: controller.scrollController,
        children: [
          _getBanner(),
          _getads(),
          _getCate(),
        ],
      ),
    );
  }

  // Banner
  Widget _getBanner() {
    return SizedBox(
      width: ScreenAdpater.getScreenWidth(),
      height: ScreenAdpater.height(682),
      // 插件的使用
      child: Obx(() => Swiper(
            pagination: const SwiperPagination(
                builder: SwiperPagination.rect,
                alignment: Alignment.bottomCenter),
            autoplay: true,
            loop: true,
            itemCount: controller.bannerDataList.length,
            itemBuilder: (context, index) {
              FocusItemModel item = controller.bannerDataList[index];
              String url = "$host${item.pic}";
              String newurl = url.replaceAll("\\", "/");
              return Image.network(
                newurl,
                fit: BoxFit.cover,
              );
            },
          )),
    );
  }

  // 广告
  Widget _getads() {
    return SizedBox(
      width: ScreenAdpater.getScreenWidth(),
      height: ScreenAdpater.height(92),
      child: Image.asset(
        "assets/images/xiaomiBanner.png",
        fit: BoxFit.cover,
      ),
    );
  }

  // 分类
  Widget _getCate() {
    return SizedBox(
      width: ScreenAdpater.getScreenWidth(),
      height: ScreenAdpater.height(500),
      child: Obx(() {
        return Swiper(
          pagination: const SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: SwiperPagination.rect),
          itemCount: controller.cateDataList.length ~/ 10, //页数
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: GridView.builder(
                  itemCount: controller.cateDataList.length,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: ScreenAdpater.width(4),
                      crossAxisSpacing: ScreenAdpater.height(4)),
                  itemBuilder: (context, index) {
                    CateItemModel item = controller.cateDataList[index];
                    var url = item.pic!.replaceAll("\\", "/");
                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: ScreenAdpater.height(140),
                          width: ScreenAdpater.width(140),
                          child: Image.network(
                            "$host$url",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Text(item.title!),
                        )
                      ],
                    );
                  }),
            );
          },
        );
      }),
    );
  }
}
