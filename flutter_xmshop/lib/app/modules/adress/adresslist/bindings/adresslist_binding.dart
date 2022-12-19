import 'package:get/get.dart';

import '../controllers/adresslist_controller.dart';

class AdresslistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdresslistController>(
      () => AdresslistController(),
    );
  }
}
