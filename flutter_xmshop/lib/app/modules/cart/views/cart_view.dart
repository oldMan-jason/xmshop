import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import './availab_view.dart';
import './invalid_view.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          "购物车",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        color: Colors.grey[200],
        child: Stack(
          children: [
            ListView(
              children: [
                AvailabView(),
                SizedBox(
                  height: 20,
                ),
                InvalidView()
              ],
            ),
            BottomActionView(),
          ],
        ),
      ),
    );
  }
}

class BottomActionView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
            width: double.infinity,
            height: 60,
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.circle_outlined)),
                          Text(
                            "全选",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(top: 10),
                      alignment: Alignment.centerRight,
                      child: Column(
                        children: [
                          Text("合计(不含运费) ￥98元"),
                          Text("免运费 优惠 ￥0.01 "),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        width: 150,
                        height: 60,
                        alignment: Alignment.center,
                        child: TextButton(
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(Size(100, 60)),
                            // padding:
                            // MaterialStateProperty.all(EdgeInsets.all(10)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            textStyle: MaterialStateProperty.all(TextStyle(
                              fontSize: 18,
                            )),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.orange),
                          ),
                          onPressed: () {},
                          child: Text("结算(2)"),
                        ))),
              ],
            )));
  }
}
