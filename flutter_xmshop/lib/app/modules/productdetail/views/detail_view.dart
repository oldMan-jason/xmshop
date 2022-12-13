import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../controllers/productdetail_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailView extends GetView {
  @override
  final ProductdetailController controller = Get.find();
  // 函数入参
  final Function posinWidget;

  DetailView(this.posinWidget, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      key: controller.globalKey2,
      alignment: Alignment.center,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          // 悬浮
          posinWidget(),
          Container(
            width: double.infinity,
            child: Obx(() {
              return controller.selectSubTabsIndex.value == 1
                  ? Container(
                      width: double.infinity,
                      child: controller.item.value.content != null
                          ? Html(
                              data: controller.item.value.content,
                              style: {
                                "body": Style(backgroundColor: Colors.white),
                                "p": Style(fontSize: FontSize.large),
                              },
                            )
                          : Text(""),
                    )
                  : Container(
                      width: double.infinity,
                      child: controller.item.value.specs != null
                          ? Html(
                              data: controller.item.value.specs,
                              style: {
                                "body": Style(backgroundColor: Colors.white),
                                "p": Style(fontSize: FontSize.large),
                              },
                            )
                          : Text(""),
                    );
            }),
          )
        ],
      ),
    );
  }
}
