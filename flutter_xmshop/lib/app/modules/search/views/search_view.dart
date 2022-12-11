import 'package:flutter/material.dart';
import 'package:flutter_xmshop/app/tool/loadassets.dart';
import 'package:flutter_xmshop/app/tool/screenadapter.dart';
import 'package:get/get.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);

  // appBar
  PreferredSizeWidget _setupAppBar() {
    return AppBar(
      actions: [
        TextButton(
            onPressed: () {
              Get.offAndToNamed("/productlist",
                  arguments: {"keyWord": controller.keyWord});
            },
            child: const Text(
              "搜索",
              style: TextStyle(color: Colors.black87),
            ))
      ],
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios)),
      title: Container(
        height: 44,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1.0, color: Colors.black12)),
        child: TextField(
          autofocus: true,
          textAlignVertical: TextAlignVertical.center,
          decoration: const InputDecoration(
              counterText: "",
              prefixIcon: Icon(Icons.search),
              hintText: "请输入内容...",
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.transparent),
          onChanged: (value) {
            controller.keyWord = value;
          },
          //键盘回车
          onSubmitted: (value) {
            controller.keyWord = value;
            Get.offAndToNamed("/productlist",
                arguments: {"keyWord": controller.keyWord});
          },
        ),
      ),
    );
  }

  // 标题
  Widget _section() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "搜索历史",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
        ],
      ),
    );
  }

  // 搜索历史
  Widget _searchHistory() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Wrap(
        runAlignment: WrapAlignment.center,
        direction: Axis.horizontal,
        spacing: 10,
        runSpacing: 10,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10)),
            child: Text("平台电脑"),
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(12)),
            child: Text("平台电脑"),
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(12)),
            child: Text("平台电脑"),
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(12)),
            child: Text("数码手机"),
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(12)),
            child: Text("时尚汽车美容"),
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(12)),
            child: Text("高清屏幕元器件"),
          )
        ],
      ),
    );
  }

  // 热搜
  Widget _hotSeach() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: ScreenAdpater.height(138),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: LoadAssetsImage.loadProviderImage("hot_search"))),
        ),
        Container(
          width: ScreenAdpater.getScreenWidth() - 20,
          height: 300,
          color: Colors.white,
          child: GridView.builder(
              itemCount: 8,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: ScreenAdpater.width(40),
                mainAxisSpacing: ScreenAdpater.height(20),
                childAspectRatio: 3 / 1,
              ),
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: ScreenAdpater.width(120),
                      padding: EdgeInsets.all(ScreenAdpater.width(10)),
                      child: Image.network(
                        "https://www.itying.com/images/shouji.png",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(ScreenAdpater.width(10)),
                      alignment: Alignment.topLeft,
                      child: const Text("小米净化器 热水器 小米净化器"),
                    ))
                  ],
                );
              }),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _setupAppBar(),
        body: ListView(
          children: [
            Column(
              children: [
                _section(),
                _searchHistory(),
                _hotSeach(),
              ],
            )
          ],
        ));
  }
}
