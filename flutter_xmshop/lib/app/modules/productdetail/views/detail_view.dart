import 'package:flutter/material.dart';
import '../controllers/productdetail_controller.dart';
import 'package:get/get.dart';

class DetailView extends GetView {
  @override
  final ProductdetailController controller = Get.find();
  DetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      key: controller.globalKey2,
      width: double.infinity,
      height: 1000,
      color: Colors.yellow,
    );
  }
}
