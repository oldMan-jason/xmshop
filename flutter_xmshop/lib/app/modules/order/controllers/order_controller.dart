import 'package:get/get.dart';

import '../../productdetail/cache/cartcache.dart';

class OrderController extends GetxController {
  RxList product = [].obs;

  @override
  void onInit() {
    super.onInit();
    _getAllProductData();
  }

  // 获取购物车所有商品
  _getAllProductData() async {
    List data = await CartCacheTool.getCartData();
    product.value = data;
    update();
  }

  // 总价格
  getTotalPrice() {
    double totalPrice = 0.0;
    if (product.isNotEmpty) {
      product.forEach((element) {
        if (element["checked"]) {
          int price = element["price"];
          int count = element["count"];
          int p = price * count;
          totalPrice += p;
        }
      });
    }
    return totalPrice;
  }

  // 获取总数量
  int getTotalProduct() {
    int totalCount = 0;
    if (product.isNotEmpty) {
      product.forEach((element) {
        int count = element["count"];
        totalCount += count;
      });
    }
    return totalCount;
  }
}
