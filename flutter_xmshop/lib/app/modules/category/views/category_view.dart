import 'package:flutter/material.dart';
import 'package:flutter_xmshop/app/tool/screenadapter.dart';
import 'package:get/get.dart';
import '../controllers/category_controller.dart';

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

  Widget _setupBody() {
    return Center(
      child: Text(
        'CategoryView is working',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
