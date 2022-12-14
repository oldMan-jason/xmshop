import 'package:flutter/material.dart';
import 'package:flutter_xmshop/app/modules/productdetail/controllers/productdetail_controller.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class GoodsheetView extends GetView {
  final ProductdetailController p = Get.find<ProductdetailController>();

  GoodsheetView({Key? key}) : super(key: key);

  Widget _stepCount() {
    return Container(
      width: 80,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12, width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 20,
            height: 30,
            child: TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(0))),
                onPressed: () {
                  p.decNumber();
                },
                child: Text(
                  "-",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
          ),
          Container(
            height: 30,
            width: 1,
            color: Colors.grey[200],
          ),
          Container(
            width: 20,
            height: 30,
            child: TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(0))),
                onPressed: () {},
                child: Text(
                  "${p.buyNumber.value}",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
          ),
          Container(
            height: 30,
            width: 1,
            color: Colors.grey[200],
          ),
          Container(
            width: 20,
            height: 30,
            child: TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(0))),
                onPressed: () {
                  p.incNumber();
                },
                child: Text(
                  "+",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
          ),
        ],
      ),
    );
  }

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
        child: Stack(
          children: [
            ListView(
              children: [
                ...[
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
                      Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "￥${p.item.value.price}",
                                style: TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              Text(
                                p.item.value.subTitle!,
                                softWrap: true,
                                maxLines: 4,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ))
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
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black)),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(
                                  color: e.choose
                                      ? Colors.red
                                      : Colors.transparent,
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
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black)),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: e.choose
                                      ? Colors.red
                                      : Colors.transparent,
                                  width: 1),
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      );
                    }).toList(),
                  ),
                ],
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "数量",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      _stepCount(),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 40,
                child: Container(
                  height: 44,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () {
                        p.sureBuyAction();
                        Get.back();
                      },
                      child: Text("确定")),
                ))
          ],
        ));
  }
}
