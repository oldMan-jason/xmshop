import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/adressedit_controller.dart';
import 'package:city_pickers/city_pickers.dart';

class AdresseditView extends GetView<AdresseditController> {
  const AdresseditView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('新建收货地址'),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: Obx(() {
          return Stack(
            children: [
              ListView(
                children: [
                  // 姓名
                  Container(
                    color: Colors.white,
                    height: 60,
                    width: double.infinity,
                    child: ListTile(
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "姓名 ",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: controller.nameTexteditingVC,
                                decoration: InputDecoration(
                                    hintText: "填写收货人姓名",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        fontSize: 15, color: Colors.grey[300])),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    height: 1,
                  ),
                  // 电话
                  Container(
                    color: Colors.white,
                    height: 60,
                    width: double.infinity,
                    child: ListTile(
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "电话 ",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: controller.telTexteditingVC,
                                decoration: InputDecoration(
                                    hintText: "填写收货人电话",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        fontSize: 15, color: Colors.grey[300])),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 5,
                    width: double.infinity,
                    color: Colors.grey[200],
                  ),
                  // 所在地区
                  Container(
                    color: Colors.white,
                    height: 60,
                    width: double.infinity,
                    child: ListTile(
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "所在地区 ",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              flex: 1,
                              child: TextButton(
                                onPressed: () async {
                                  Result? result =
                                      await CityPickers.showCityPicker(
                                    context: context,
                                  );
                                  if (result != null) {
                                    controller.selectAddres.value =
                                        result.provinceName! +
                                            result.cityName! +
                                            result.areaName!;
                                  }
                                },
                                child: Text(
                                  controller.selectAddres.value.length > 0
                                      ? controller.selectAddres.value
                                      : "选择地区",
                                ),
                                style: ButtonStyle(
                                    alignment:
                                        Alignment.centerLeft, //button文字对齐方式
                                    textStyle:
                                        MaterialStateProperty.all(TextStyle(
                                      fontSize: 16,
                                    )),
                                    foregroundColor:
                                        controller.selectAddres.value.isNotEmpty
                                            ? MaterialStateProperty.all(
                                                Colors.black)
                                            : MaterialStateProperty.all(
                                                Colors.grey[300])),
                              ))
                        ],
                      ),
                    ),
                  ),
                  // 详细地址
                  Container(
                    color: Colors.white,
                    height: 60,
                    width: double.infinity,
                    // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ListTile(
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "详细地址 ",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller:
                                    controller.addreeDetailTexteditingVC,
                                decoration: InputDecoration(
                                    hintText: "小区、楼牌号",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        fontSize: 15, color: Colors.grey[300])),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 5,
                    width: double.infinity,
                    color: Colors.grey[200],
                  ),
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text("设置为默认地址"),
                      subtitle: Text("提醒：通常使用该地址下单"),
                      trailing: Switch(
                        activeColor: Colors.blue,
                        inactiveTrackColor: Colors.grey,
                        value: controller.isdef.value,
                        onChanged: (val) {
                          controller.openDefalutAdress(val);
                        },
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: InkWell(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      controller.model != null
                          ? controller.updateAddress()
                          : controller.saveAddress();

                      Future.delayed(
                        Duration(milliseconds: 600),
                      ).whenComplete(() {
                        Get.back();
                      });
                    },
                    child: Container(
                      height: 58,
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      alignment: Alignment.center,
                      color: Colors.orange,
                      child: Text(
                        controller.model != null ? "更新并使用" : "保存并使用",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ))
            ],
          );
        }));
  }
}
