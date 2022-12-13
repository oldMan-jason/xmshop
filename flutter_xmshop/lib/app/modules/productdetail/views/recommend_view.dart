import 'package:flutter/material.dart';
import '../controllers/productdetail_controller.dart';
import 'package:get/get.dart';

class RecommendView extends GetView {
  @override
  final ProductdetailController controller = Get.find();
  RecommendView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      key: controller.globalKey3,
      width: double.infinity,
      height: 1000,
      color: Colors.pink,
    );
  }
}
