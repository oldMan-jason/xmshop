import 'dart:convert';

import '..../../../../adressedit/models/address_model.dart';
import 'package:get/get.dart';
import '../../../../tool/cachetool.dart';
import '../../../order/controllers/order_controller.dart';

class AdresslistController extends GetxController {
  final OrderController orderController = Get.find<OrderController>();

  RxList<AddressModel> adList = <AddressModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // CacheTool.removeObject("address");
    getAddressFromCache();
  }

  // 从缓存获取数据
  getAddressFromCache() async {
    var val = await CacheTool.getObject("address");
    if (val != null) {
      List list = json.decode(val);
      List<AddressModel> tmpArray = [];
      for (var i = 0; i < list.length; i++) {
        var data = list[i];
        var model = AddressModel.fromJson(data);
        model.id = i;
        tmpArray.add(model);
      }
      adList.value = tmpArray;
      print("从本地查询个数 -- ${adList.length}");
      update();
    }
  }

  updateData(AddressModel model) async {
    var val = await CacheTool.getObject("address");
    if (val != null) {
      var map = model.toJson();
      List tmpArray = [];
      List list = json.decode(val);
      for (var i = 0; i < list.length; i++) {
        if (model.id == i) {
          tmpArray.add(map);
        } else {
          tmpArray.add(list[i]);
        }
      }
      await CacheTool.saveObject("address", json.encode(tmpArray));
      getAddressFromCache();
    }
  }

  // 删除
  deleteData(AddressModel model) {
    List<AddressModel> tmp = [];
    List newCache = [];
    adList.forEach((element) {
      if (element.id != model.id) {
        newCache.add(element.toJson());
        tmp.add(element);
      }
    });
    adList.value = tmp;
    CacheTool.saveObject("address", json.encode(newCache));
    update();
  }

  sureAddress(AddressModel model) {
    orderController.insertAddress(model);
  }
}
