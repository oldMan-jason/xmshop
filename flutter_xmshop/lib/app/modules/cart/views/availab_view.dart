import 'package:flutter/material.dart';
import 'package:flutter_xmshop/app/tool/httpclient.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

/**
 *  有效商品view
 */
class AvailabView extends GetView {
  AvailabView({Key? key}) : super(key: key);
  // 组件绑定vc
  final CartController cartController = Get.find<CartController>();

  Widget _section1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 单选
        Container(
          padding: EdgeInsets.only(left: 10),
          height: 34,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  print("商铺全选了");
                  cartController.shopSelect();
                },
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cartController.shopAllSelect.value
                          ? Colors.black
                          : Colors.white,
                      border: Border.all(
                          color: Color.fromARGB(255, 241, 231, 231), width: 2)),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "小米自营1",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        TextButton.icon(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.only(right: 10))),
            onPressed: () {},
            icon: Icon(
              Icons.water_drop_outlined,
            ),
            label: Text(
              "已免运费",
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ))
      ],
    );
  }

  // 单个添加的商品
  Widget _product(val) {
    return Container(
      height: 150,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        children: [
          Checkbox(
              value: val["checked"],
              onChanged: (boxVal) {
                cartController.selectProduct(val["_id"]);
              }),
          Image.network(
            HttpClient.replacePicUrl(val["pic"]),
            fit: BoxFit.contain,
            width: 80,
            height: 80,
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    val["title"],
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                  Chip(
                    label: Text(val["selectedAttr"]),
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "￥",
                        style: TextStyle(color: Colors.red, fontSize: 12)),
                    TextSpan(
                        text: "${val["price"]}",
                        style: TextStyle(color: Colors.red, fontSize: 18))
                  ])),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Text("预估到手价${val["price"]}"),
                    decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(20)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // 迭代器
  Widget _stepCount(val) {
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
                  cartController.removeProduct(val["_id"]);
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
                  "${val["count"]}",
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
                  cartController.addProduct(val["_id"]);
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
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(bottom: 10),
      constraints: BoxConstraints(),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          _section1(),
          // 标题
          ...cartController.cacheList.map(
            (e) {
              return Stack(
                children: [
                  _product(e),
                  Positioned(right: 10, bottom: 20, child: _stepCount(e))
                ],
              );
            },
          ).toList(),
        ],
      ),
    );
  }
}
