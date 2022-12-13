import 'package:flutter/material.dart';

import 'package:get/get.dart';

class InvalidView extends GetView {
  const InvalidView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }
}
