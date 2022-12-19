import 'dart:convert';

import '..../../../../adressedit/models/address_model.dart';
import 'package:get/get.dart';
import '../../../../tool/cachetool.dart';

class AdresslistController extends GetxController {
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
      list.forEach((map) {
        var model = AddressModel.fromJson(map);
        tmpArray.add(model);
      });
      adList.value = tmpArray;
      print("从本地查询个数 -- ${adList.length}");
      update();
    }
  }
}
