import 'package:flutter/material.dart';
import 'package:flutter_xmshop/app/modules/productdetail/views/goodsheet_view.dart';
import 'package:flutter_xmshop/app/tool/screenadapter.dart';
import 'package:get/get.dart';
import '../controllers/productdetail_controller.dart';
import '../models/pcontent.dart';
import '../../../tool/httpclient.dart';

class GoodsView extends GetView {
  @override
  final ProductdetailController controller = Get.find();
  GoodsView({Key? key}) : super(key: key);

  //底部弹窗
  _bottomSheet() {
    Get.bottomSheet(GetBuilder(
        init: controller,
        builder: (controller) {
          return GoodsheetView();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.item.value.sId != null
          ? Container(
              key: controller.globalKey1,
              width: double.infinity,
              height: 1000,
              child: Column(
                children: [
                  // 图片
                  AspectRatio(
                      aspectRatio: 16 / 12,
                      child: Image.network(HttpClient.replacePicUrl(
                          controller.item.value.pic!))),
                  Container(
                    margin: const EdgeInsets.all(10),
                    constraints: BoxConstraints(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            width: 240,
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${controller.item.value.title}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.black),
                                ),
                                Text("${controller.item.value.subTitle}"),
                                Chip(
                                  label: Text(
                                    "Redmi手机品牌",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                )
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "到手价",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12),
                                  ),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: "￥",
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 12)),
                                    TextSpan(
                                        text: "${controller.item.value.price}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 34,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: "起",
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 12)),
                                  ]))
                                ],
                              ),
                            ))
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  // 价格
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                                text: "折扣￥",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                                children: [
                              TextSpan(
                                  text: "${controller.item.value.price}",
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold))
                            ])),
                        RichText(
                            text: TextSpan(
                                text: "原价￥",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                                children: [
                              TextSpan(
                                  text: "${controller.item.value.oldPrice}",
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold))
                            ]))
                      ],
                    ),
                  ),
                  // 已选择
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: InkWell(
                      onTap: _bottomSheet,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  "已选:",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextButton(
                                  onPressed: _bottomSheet,
                                  child: Text(
                                    "我是已选的结果饭卡发发火",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_right_sharp,
                            color: Colors.black38,
                            size: 34,
                          )
                        ],
                      ),
                    ),
                  ),
                  // 服务
                  Container(
                    height: 100,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "服务:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: 300,
                              child: Image.asset(
                                "assets/images/service.png",
                                fit: BoxFit.fitWidth,
                              ),
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_right_sharp,
                          color: Colors.black38,
                          size: 34,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          : Container(
              height: ScreenAdpater.getScreenHeight(),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
    });
  }
}
