import 'package:flutter/material.dart';
import '../controllers/productdetail_controller.dart';
import 'package:get/get.dart';

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
      width: double.infinity,
      // constraints: BoxConstraints(),
      height: 300,
      color: Colors.yellow,
      child: Column(
        children: [
          posinWidget(),
        ],
      ),
    );
  }
}
