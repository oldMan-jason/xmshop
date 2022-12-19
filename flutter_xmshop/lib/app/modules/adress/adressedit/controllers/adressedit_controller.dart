import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../tool/cachetool.dart';
import '../../adresslist/controllers/adresslist_controller.dart';
import '../models/address_model.dart';

class AdresseditController extends GetxController {
  // 传值
  AddressModel? model = Get.arguments;

  final AdresslistController addressListVC = Get.find<AdresslistController>();
  final TextEditingController nameTexteditingVC = TextEditingController();
  final TextEditingController telTexteditingVC = TextEditingController();
  final TextEditingController addreeDetailTexteditingVC =
      TextEditingController();

  // 是否设置为默认地址
  RxBool isdef = false.obs;
  RxString selectAddres = "".obs;
  List allAdress = [];
  // 记录缓存记录的索引
  int index = 0;

  @override
  void onInit() async {
    super.onInit();

    // 设置默认值
    if (model != null) {
      nameTexteditingVC.text = model!.name!;
      telTexteditingVC.text = model!.tel!;
      addreeDetailTexteditingVC.text = model!.detail!;
      selectAddres.value = model!.address!;
      isdef.value = model!.isdefl!;
    }

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

  // 新增保存
  saveAddress() {
    if (!isValidData()) {
      return;
    }

    var name = nameTexteditingVC.text;
    var tel = telTexteditingVC.text;
    var detail = addreeDetailTexteditingVC.text;
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

  // 更新地址
  updateAddress() {
    if (!isValidData()) {
      return;
    }

    if (model != null) {
      var name = nameTexteditingVC.text;
      var tel = telTexteditingVC.text;
      var detail = addreeDetailTexteditingVC.text;

      model?.name = name;
      model?.tel = tel;
      model?.address = selectAddres.value;
      model?.detail = detail;
      model?.isdefl = isdef.value;
      addressListVC.updateData(model!);
    }
  }

  // 校验
  bool isValidData() {
    var name = nameTexteditingVC.text;
    var tel = telTexteditingVC.text;
    var detail = addreeDetailTexteditingVC.text;
    if (name.length == 0) {
      Get.snackbar("提示", "请输入姓名");
      return false;
    } else if (tel.length == 0 || tel.length != 11) {
      Get.snackbar("提示", "请输入正确手机号！");
      return false;
    } else if (detail.length == 0) {
      Get.snackbar("提示", "请输入详细地址！");
      return false;
    } else if (selectAddres.isEmpty) {
      Get.snackbar("提示", "请选择所在地区！");
      return false;
    }
    return true;
  }
}
