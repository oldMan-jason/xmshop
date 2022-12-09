import 'dart:ui';

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
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/stream_model.dart';

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
        shrinkWrap: true,
        controller: controller.scrollController,
        children: [
          _getBanner(),
          _getads(),
          _getCate(),
          _getRecommend(),
          _hotSelling(),
          _waterfall(),
        ],
      ),
    );
  }

  // Banner
  Widget _getBanner() {
    return SizedBox(
      width: ScreenAdpater.getScreenWidth(),
      height: ScreenAdpater.height(682),
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
        var c = controller.cateDataList.length ~/ 10;
        return Swiper(
          pagination: const SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: SwiperPagination.rect),
          itemCount: c, //页数
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10, //一页固定10个item
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: ScreenAdpater.width(5),
                      crossAxisSpacing: ScreenAdpater.height(5)),
                  itemBuilder: (context, i) {
                    CateItemModel item =
                        controller.cateDataList[index * 10 + i];
                    var url = item.pic!.replaceAll("\\", "/");
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.white,
                          alignment: Alignment.center,
                          height: ScreenAdpater.height(120),
                          width: ScreenAdpater.width(120),
                          child: Image.network(
                            "$host$url",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Text(
                            item.title!,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
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

  // 推荐
  Widget _getRecommend() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: ScreenAdpater.height(420),
            // 添加带圆角的图片
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/xiaomiBanner2.png"))),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: ScreenAdpater.height(260),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/tuijian01.png"))),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/tuijian03.png"))),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/tuijian02.png"))),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // 热销臻选列表
  List<Widget> _hotList() {
    List<Widget> result = controller.hotList.map((element) {
      String url = "$host${element.pic}";
      url = url.replaceAll("\\", "/");
      return Expanded(
        flex: 1,
        child: Container(
          height: ScreenAdpater.height(240),
          margin: EdgeInsets.fromLTRB(0, 0, 0, ScreenAdpater.height(20)),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(246, 246, 246, 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    SizedBox(height: ScreenAdpater.height(20)),
                    Text(element.title,
                        style: TextStyle(
                            fontSize: ScreenAdpater.fontSize(38),
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: ScreenAdpater.height(20)),
                    Text(element.subTitle,
                        style: TextStyle(fontSize: ScreenAdpater.fontSize(28))),
                    SizedBox(height: ScreenAdpater.height(20)),
                    Text("￥${element.price}元",
                        style: TextStyle(fontSize: ScreenAdpater.fontSize(34)))
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(ScreenAdpater.height(8)),
                  child: Image.network(url, fit: BoxFit.cover),
                ),
              )
            ],
          ),
        ),
      );
    }).toList();
    return result;
  }

  // 热销臻选
  Widget _hotSelling() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        //标题
        Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          height: ScreenAdpater.height(100),
          child: Stack(
            children: [
              const Positioned(
                  left: 0,
                  top: 0,
                  child: Text(
                    "热销甄选",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )),
              Positioned(
                  right: 0,
                  top: 0,
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "更多手机推荐 >",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 158, 138, 138)),
                      )))
            ],
          ),
        ),
        SizedBox(
          height: ScreenAdpater.height(10),
        ),
        // 轮播和臻选项
        Padding(
          padding: EdgeInsets.fromLTRB(ScreenAdpater.width(20),
              ScreenAdpater.height(10), ScreenAdpater.width(20), 0),
          child: Obx(() => Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        height: ScreenAdpater.height(740),
                        color: Colors.white,
                        child: Swiper(
                          itemCount: controller.hotSellingDataList.length,
                          loop: true,
                          autoplay: true,
                          pagination: const SwiperPagination(
                              builder: SwiperPagination.rect,
                              alignment: Alignment.bottomCenter),
                          itemBuilder: (context, index) {
                            FocusItemModel item =
                                controller.hotSellingDataList[index];
                            String pic = "$host${item.pic}";
                            var picUrl = pic.replaceAll("\\", "/");
                            return Image.network(
                              picUrl,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      )),
                  SizedBox(
                    width: ScreenAdpater.height(10),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                          height: ScreenAdpater.height(740),
                          color: Colors.white,
                          child: Column(children: _hotList())))
                ],
              )),
        ),
      ],
    );
  }

  // 瀑布流
  Widget _waterfall() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "省心优惠",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("更多优惠 >",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 158, 138, 138))),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Obx(() => MasonryGridView.count(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: controller.streamList.length,
                  crossAxisCount: 2,
                  mainAxisSpacing: ScreenAdpater.height(20),
                  crossAxisSpacing: ScreenAdpater.width(20),
                  itemBuilder: (context, index) {
                    SteamItemModel item = controller.streamList[index];
                    var url = "$host${item.sPic}";
                    url = url.replaceAll("\\", "/");
                    return Container(
                      padding: EdgeInsets.all(ScreenAdpater.width(20)),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 248, 247, 247),
                          borderRadius: BorderRadius.circular(14)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            url,
                            fit: BoxFit.cover,
                          ),
                          Text(item.title),
                          Text(item.subTitle),
                          Text("价格：￥${item.price}"),
                        ],
                      ),
                    );
                  })),
            )
          ],
        ));
  }
}
