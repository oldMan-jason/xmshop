import 'package:flutter/material.dart';
import 'package:flutter_xmshop/app/tool/httpclient.dart';
import 'package:get/get.dart';
import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({Key? key}) : super(key: key);

// 添加地址
  Widget _addNewAddress() {
    return InkWell(
      onTap: () {
        print("添加地址");
      },
      child: Container(
        margin: EdgeInsets.all(15),
        height: 68,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
              width: 200,
              height: 68,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.add_home_rounded),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "添加新地址",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Icon(Icons.chevron_right_sharp),
            )
          ],
        ),
      ),
    );
  }

// 购买的商品
  List<Widget> _payProduct() {
    return controller.product.map((e) {
      return Container(
        height: 100,
        margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              width: 80,
              height: 80,
              child: Image.network(
                HttpClient.replacePicUrl(e["pic"]),
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e["title"],
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Text("￥ ${e["price"]}",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(e["selectedAttr"]),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Text("x ${e["count"]}",
                              style: TextStyle(color: Colors.grey[500])),
                        ),
                      ],
                    )
                  ],
                ))
          ],
        ),
      );
    }).toList();
  }

  List<Widget> _other() {
    final title = ["运费", "优惠券", "礼品卡"];
    final subtitle = ["包邮", "无可用 >", "无可用 >"];
    return List.generate(3, (index) {
      return InkWell(
        onTap: () {
          if (index != 0) {
            print(title[index]);
          }
        },
        child: Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title[index],
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
              Text(
                subtitle[index],
                style: TextStyle(
                    fontSize: 17,
                    color: index == 0 ? Colors.black : Colors.grey[350]),
              )
            ],
          ),
        ),
      );
    });
  }

  // 其他信息
  Widget _otherInfo() {
    return Container(
      margin: EdgeInsets.all(15),
      height: 140,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Column(
          children: _other(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('确认订单'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        return Stack(
          children: [
            ListView(
              children: [
                _addNewAddress(),
                ..._payProduct(),
                _otherInfo(),
              ],
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 80,
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          top: BorderSide(
                              color: Color.fromARGB(255, 246, 235, 235),
                              width: 1))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "共计${controller.getTotalProduct()}, 合计: ",
                            style:
                                TextStyle(color: Colors.black, fontSize: 17)),
                        TextSpan(
                            text: "￥ ${controller.getTotalPrice()}",
                            style: TextStyle(color: Colors.red, fontSize: 17))
                      ])),
                      Container(
                        width: 100,
                        height: 44,
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "去付款",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            )),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.red[300]),
                      )
                    ],
                  ),
                ))
          ],
        );
      }),
    );
  }
}
