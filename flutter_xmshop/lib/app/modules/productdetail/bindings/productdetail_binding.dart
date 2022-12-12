import 'package:get/get.dart';

import '../controllers/productdetail_controller.dart';

class ProductdetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductdetailController>(
      () => ProductdetailController(),
    );
  }
}
