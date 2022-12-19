import 'package:flutter_xmshop/app/tool/cachetool.dart';
import 'package:get/get.dart';
import '../../productdetail/cache/cartcache.dart';

class CartController extends GetxController {
  // 有效商品全选
  RxInt shopName = 1.obs;
  RxList cacheList = [].obs;
  RxBool shopAllSelect = true.obs;

  @override
  void onInit() {
    super.onInit();
    // CacheTool.clear("cartKey");
  }

  // 选择某一个商店全选或者全不选
  shopSelect() {
    shopAllSelect.value = !shopAllSelect.value;
    cacheList.forEach((element) {
      element["checked"] = shopAllSelect.value;
    });
    update();
  }

  // 单个商品选择
  selectProduct(id) {
    bool isAllselect = true;
    cacheList.forEach((element) {
      if (element["_id"] == id) {
        element["checked"] = !element["checked"];
      }

      if (!element["checked"]) {
        isAllselect = false;
      }
    });
    shopAllSelect.value = isAllselect;
    print("单个商品的ID --${id}\n 总集合--${cacheList}");
    update();
  }

  addProduct(id) {
    cacheList.forEach((element) {
      if (element["_id"] == id) {
        element["count"] = ++element["count"];
      }
    });
    print("单个商品的ID --${id}\n 总集合--${cacheList}");
    getTotalPrice();
    update();
  }

  removeProduct(id) {
    cacheList.forEach((element) {
      if (element["_id"] == id) {
        if (element["count"] > 1) {
          element["count"] = --element["count"];
        }
      }
    });
    print("单个商品的ID --${id}\n 总集合--${cacheList}");
    update();
  }

  getTotalPrice() {
    double totalPrice = 0.0;
    if (cacheList.isNotEmpty) {
      cacheList.forEach((element) {
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
    if (cacheList.isNotEmpty) {
      cacheList.forEach((element) {
        int count = element["count"];
        totalCount += count;
      });
    }
    return totalCount;
  }

  getAddCartData() async {
    List data = await CartCacheTool.getCartData();
    cacheList.value = data;
    update();
  }
}
