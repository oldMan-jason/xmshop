import 'package:flutter/material.dart';
import 'package:flutter_xmshop/app/modules/productdetail/controllers/productdetail_controller.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class GoodsheetView extends GetView {
  final ProductdetailController p = Get.find<ProductdetailController>();

  GoodsheetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        height: 1000,
        decoration: BoxDecoration(
            // 需要设置color，否则是透明效果
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: ListView(
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 120,
                  height: 120,
                  child: Image.asset(
                    "assets/images/placeholder.png",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "￥699",
                      style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                    Text(
                      "Redmi 10A 4GB+64GB 烟波蓝",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                )
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Text(
                "${p.item.value.attr![0].cate}",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 20,
              runSpacing: 10,
              children: p.attModel[0].list!.map((e) {
                return GestureDetector(
                  onTap: () {
                    p.updateSheetFlag1(e.title!);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(e.title!,
                        style: TextStyle(fontSize: 17, color: Colors.black)),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(
                            color: e.choose ? Colors.red : Colors.transparent,
                            width: 1),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                );
              }).toList(),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Text(
                "${p.item.value.attr![1].cate}",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 20,
              runSpacing: 10,
              children: p.attModel[1].list!.map((e) {
                return InkWell(
                  onTap: () {
                    p.updateSheetFlag2(e.title!);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(e.title!,
                        style: TextStyle(fontSize: 17, color: Colors.black)),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: e.choose ? Colors.red : Colors.transparent,
                            width: 1),
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(15)),
                  ),
                );
              }).toList(),
            ),
          ],
        ));
  }
}
