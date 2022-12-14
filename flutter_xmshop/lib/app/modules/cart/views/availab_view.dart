import 'package:flutter/material.dart';
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
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                        color: Color.fromARGB(255, 241, 231, 231), width: 2)),
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
  Widget _product() {
    return Container(
      height: 150,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        children: [
          Radio(value: 0, groupValue: 1, onChanged: (val) {}),
          Image.asset(
            "assets/images/placeholder.png",
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
                    "蓝牙手机支架八兆的少的",
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                  Chip(
                    label: Text("黑色"),
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "￥",
                        style: TextStyle(color: Colors.red, fontSize: 12)),
                    TextSpan(
                        text: "89",
                        style: TextStyle(color: Colors.red, fontSize: 18))
                  ])),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Text("预估到手价￥89.00"),
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
                onPressed: () {},
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
                  "1",
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
          // 标题
          _section1(),
          Stack(
            children: [
              _product(),
              Positioned(right: 10, bottom: 20, child: _stepCount())
            ],
          ),

          Stack(
            children: [
              _product(),
              Positioned(right: 10, bottom: 20, child: _stepCount())
            ],
          ),
          Stack(
            children: [
              _product(),
              Positioned(right: 10, bottom: 20, child: _stepCount())
            ],
          )
        ],
      ),
    );
  }
}
