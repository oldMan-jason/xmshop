import 'package:flutter/material.dart';
import 'package:flutter_xmshop/app/tool/httpclient.dart';
import 'package:flutter_xmshop/app/tool/loadassets.dart';
import 'package:get/get.dart';
import '../../../tool/screenadapter.dart';
import '../controllers/productlist_controller.dart';
import '../models/product_model.dart';

class ProductlistView extends GetView<ProductlistController> {
  const ProductlistView({Key? key}) : super(key: key);

  // appBar
  PreferredSizeWidget _setupAppBar() {
    return AppBar(
      actions: const [Text("")],
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios)),
      title: InkWell(
        onTap: () {
          Get.offAndToNamed("/search");
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(ScreenAdpater.width(0),
              ScreenAdpater.height(20), ScreenAdpater.width(20), 0),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            width: double.infinity,
            height: ScreenAdpater.height(88),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(246, 247, 248, 1),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                LoadAssetsImage.loadAssetsName("xmsearch"),
                Text(
                  (Get.arguments is Map)
                      ? (Get.arguments["keyWord"] ?? "请输入内容...")
                      : "请输入内容...",
                  style: const TextStyle(
                      fontSize: 14, color: Color.fromRGBO(156, 157, 158, 1)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 刷新
  Widget _progressWidget() {
    if (controller.hasData.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return const Center(
      child: Text("没有更多数据了..."),
    );
  }

  Widget _setupListView() {
    return Stack(
      children: [_listView(), _changeView()],
    );
  }

  // 筛选
  Widget _changeView() {
    return Positioned(
        left: 0,
        top: 0,
        right: 0,
        height: 44,
        child: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: controller.subHeaderList.map((e) {
              return InkWell(
                onTap: () {
                  controller.chanageOptions(e["id"]);
                },
                child: Expanded(
                    flex: 1,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            e["title"],
                            style: TextStyle(
                                color: controller.sort.value == e["id"]
                                    ? Colors.red
                                    : Colors.grey),
                          ),
                          // arrow_drop_up_outlined
                          (controller.sort.value == e["id"] &&
                                  controller.arrow.value == 1)
                              ? const Icon(Icons.arrow_drop_up_outlined)
                              : const Icon(Icons.arrow_drop_down_outlined),
                        ])),
              );
            }).toList(),
          );
        }));
  }

  // 列表
  Widget _listView() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: Obx(() => controller.listData.isNotEmpty
          ? ListView.builder(
              controller: controller.scrollController, //监听滚动刷新
              itemCount: controller.listData.length,
              itemBuilder: (context, index) {
                PlistItemModel item = controller.listData[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          SizedBox(
                            width: ScreenAdpater.width(480),
                            height: ScreenAdpater.height(350),
                            child: Image.network(
                              HttpClient.replacePicUrl(item.sPic!),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title!,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                item.subTitle!,
                                style: const TextStyle(fontSize: 16),
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: "￥",
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                      children: [
                                    TextSpan(
                                        text: "${item.price!}",
                                        style: const TextStyle(
                                            fontSize: 17, color: Colors.red))
                                  ])),
                            ],
                          ))
                        ],
                      ),
                    ),
                    (index == controller.listData.length - 1)
                        ? _progressWidget()
                        : const Text("")
                  ],
                );
              })
          : _progressWidget()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.globalKey,
      endDrawer: const Drawer(
        child: Text("开始赛选了"),
      ),
      appBar: _setupAppBar(),
      body: _setupListView(),
    );
  }
}

/**
 * 
 */
