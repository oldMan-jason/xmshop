import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../tool/cachetool.dart';
import '../../adresslist/controllers/adresslist_controller.dart';

class AdresseditController extends GetxController {
  final AdresslistController addressListVC = Get.find<AdresslistController>();
  final TextEditingController nameTexteditingVC = TextEditingController();
  final TextEditingController telTexteditingVC = TextEditingController();
  final TextEditingController addreeDetailTexteditingVC =
      TextEditingController();

  // 是否设置为默认地址
  RxBool isdef = false.obs;
  RxString selectAddres = "".obs;
  List allAdress = [];

  @override
  void onInit() async {
    super.onInit();
    var val = await CacheTool.getObject("address");
    if (val != null) {
      allAdress = json.decode(val);
    }
  }

  @override
  void onClose() {
    addressListVC.getAddressFromCache();
    super.onClose();
  }

  // 开启默认地址
  void openDefalutAdress(val) {
    isdef.value = val;
    update();
  }

  saveAddress() {
    //姓名
    var name = nameTexteditingVC.text;
    var tel = telTexteditingVC.text;
    var detail = addreeDetailTexteditingVC.text;

    if (name.length == 0) {
      Get.snackbar("提示", "请输入姓名");
      return;
    } else if (tel.length == 0 || tel.length != 11) {
      Get.snackbar("提示", "请输入正确手机号！");
      return;
    } else if (detail.length == 0) {
      Get.snackbar("提示", "请输入详细地址！");
      return;
    } else if (selectAddres.isEmpty) {
      Get.snackbar("提示", "请选择所在地区！");
      return;
    }
    Map info = {
      "name": name,
      "tel": tel,
      "address": selectAddres.value,
      "detail": detail,
      "isdefl": isdef.value
    };

    allAdress.add(info);
    print("存储的个数 -- ${allAdress.length}");
    String val = json.encode(allAdress);
    CacheTool.saveObject("address", val);
  }
}
