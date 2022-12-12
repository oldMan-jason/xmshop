import 'package:flutter/material.dart';
import 'package:flutter_xmshop/app/tool/screenadapter.dart';
import 'package:get/get.dart';
import '../controllers/productdetail_controller.dart';

import 'goods_view.dart';
import 'detail_view.dart';
import 'recommend_view.dart';
import 'goodsheet_view.dart';

class ProductdetailView extends GetView<ProductdetailController> {
  const ProductdetailView({Key? key}) : super(key: key);

  PreferredSizeWidget _appBar(context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.06),
      child: Obx(() {
        return AppBar(
          excludeHeaderSemantics: true,
          backgroundColor:
              Colors.white.withOpacity(controller.op.value), //实现透明导航
          elevation: 0, //实现透明导航
          centerTitle: true,
          title: Container(
            width: 300,
            height: 88,
            alignment: Alignment.center,
            child: controller.showTabs.value
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: controller.tabsList.map((e) {
                      return Obx(() {
                        return InkWell(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                e["title"],
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: 50,
                                height: 1,
                                color: controller.selectId.value == e["id"]
                                    ? Colors.red
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                          onTap: () {
                            controller.changeNavIndex(e["id"]);
                          },
                        );
                      });
                    }).toList())
                : const Text(""),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 15),
              width: ScreenAdpater.width(88),
              height: ScreenAdpater.width(88),
              child: ElevatedButton(
                onPressed: () {
                  showMenu(
                      color: Colors.black87.withOpacity(0.7),
                      context: context,
                      position: RelativeRect.fromLTRB(
                          ScreenAdpater.getScreenWidth() - 300, 100, 10, 100),
                      items: [
                        PopupMenuItem(
                          child: Row(
                            children: const [
                              Icon(Icons.home, color: Colors.white),
                              Text("首页", style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: const [
                              Icon(Icons.message, color: Colors.white),
                              Text("消息", style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: const [
                              Icon(Icons.star, color: Colors.white),
                              Text("收藏", style: TextStyle(color: Colors.white))
                            ],
                          ),
                        )
                      ]);
                },
                child: const Icon(Icons.share),
                style: ButtonStyle(
                  // 去除内边距
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.grey[300],
                  ),
                  // 圆形button
                  shape: MaterialStateProperty.all(const CircleBorder()),
                ),
              ),
            ),
            Container(
              width: ScreenAdpater.width(88),
              height: ScreenAdpater.width(88),
              margin: const EdgeInsets.only(right: 15),
              child: ElevatedButton(
                  onPressed: () {},
                  child: const Icon(Icons.more_horiz),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.grey[300],
                    ),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    // 圆形button
                    shape: MaterialStateProperty.all(const CircleBorder()),
                  )),
            )
          ],
          leading: Container(
            alignment: Alignment.center,
            child: Container(
              width: ScreenAdpater.width(88),
              height: ScreenAdpater.width(88),
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    alignment: Alignment.center,
                    backgroundColor: MaterialStateProperty.all(
                      Colors.grey[300],
                    ),
                    // 圆形button
                    shape: MaterialStateProperty.all(const CircleBorder()),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: const Icon(Icons.arrow_back_ios)),
            ),
          ),
        );
      }),
    );
  }

  Widget _bottom() {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: ScreenAdpater.height(200),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(
                      width: ScreenAdpater.width(2), color: Colors.black12))),
          child: Row(
            children: [
              SizedBox(
                width: ScreenAdpater.width(240),
                height: ScreenAdpater.height(160),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.shopping_cart),
                    Text(
                      "购物车",
                      style: TextStyle(fontSize: ScreenAdpater.fontSize(32)),
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    height: ScreenAdpater.height(120),
                    margin: EdgeInsets.only(right: ScreenAdpater.width(20)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(255, 165, 0, 0.9)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                              // CircleBorder()
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      onPressed: () {
                        Get.bottomSheet(GetBuilder(
                            init: controller,
                            builder: (controller) {
                              return GoodsheetView();
                            }));
                      },
                      child: Text("加入购物车"),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    height: ScreenAdpater.height(120),
                    margin: EdgeInsets.only(right: ScreenAdpater.width(20)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(253, 1, 0, 0.9)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                              // CircleBorder()
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      onPressed: () {
                        Get.bottomSheet(GetBuilder(
                            init: controller,
                            builder: (controller) {
                              return GoodsheetView();
                            }));
                      },
                      child: Text("立即购买"),
                    ),
                  ))
            ],
          ),
        ));
  }

  Widget _listView() {
    return SingleChildScrollView(
      controller: controller.scrollController,
      child: Column(
        children: [GoodsView(), DetailView(), RecommendView()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, //实现透明导航
      appBar: _appBar(context),
      body: Stack(
        children: [
          _listView(),
          _bottom(),
        ],
      ),
    );
  }
}
