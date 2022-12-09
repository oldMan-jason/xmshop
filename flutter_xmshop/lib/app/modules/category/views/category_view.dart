import 'package:flutter/material.dart';
import 'package:flutter_xmshop/app/tool/screenadapter.dart';
import 'package:get/get.dart';
import '../controllers/category_controller.dart';
import '../../../tool/httpclient.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.fromLTRB(ScreenAdpater.width(10),
              ScreenAdpater.height(20), ScreenAdpater.width(60), 0),
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
                Image.asset("assets/images/xmsearch.png"),
                const Text(
                  "请输入商品名称...",
                  style: TextStyle(
                      fontSize: 14, color: Color.fromRGBO(156, 157, 158, 1)),
                )
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset("assets/images/xmmessage.png"),
          ),
          SizedBox(
            width: ScreenAdpater.width(10),
          ),
        ],
      ),
      body: _setupBody(),
    );
  }

  // 一级分类
  Widget _leftList() {
    return SizedBox(
      height: double.infinity,
      width: ScreenAdpater.width(300),
      child: Obx(() => ListView.builder(
          itemCount: controller.leftList.length,
          itemBuilder: (context, index) {
            var item = controller.leftList[index];
            // 一级分类点击
            return InkWell(
              onTap: () {
                controller.changeCategoryByIndex(index);
              },
              child: SizedBox(
                height: ScreenAdpater.height(150),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(item.title!),
                    ),
                    Obx(() => Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: ScreenAdpater.width(10),
                            height: ScreenAdpater.height(44),
                            color: controller.selectIndex.value == index
                                ? Colors.red
                                : Colors.white,
                          ),
                        ))
                  ],
                ),
              ),
            );
          })),
    );
  }

  // 二级分类
  Widget _rightList() {
    return Expanded(
        child: SizedBox(
      height: double.infinity,
      child: Column(
        children: [
          Obx(() {
            return SizedBox(
                height: ScreenAdpater.height(120),
                width: double.infinity,
                child: GridView.builder(
                    itemCount: controller.leftList.length,
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 0.5,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          controller.leftList[index].title!,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black45),
                        ),
                      );
                    }));
          }),
          Obx(() {
            return Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: controller.rightList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 240 / 340,
                  ),
                  itemBuilder: (context, index) {
                    var item = controller.rightList[index];
                    return Column(
                      children: [
                        Image.network(
                          HttpClient.replacePicUrl(item.pic!),
                          fit: BoxFit.cover,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          alignment: Alignment.center,
                          child: Text(item.title!),
                        ),
                      ],
                    );
                  }),
            );
          })
        ],
      ),
    ));
  }

  // 初始化UI
  Widget _setupBody() {
    return Row(
      children: [_leftList(), _rightList()],
    );
  }
}
