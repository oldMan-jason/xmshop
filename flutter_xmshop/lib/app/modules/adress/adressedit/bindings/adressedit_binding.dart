import 'package:get/get.dart';

import '../controllers/adressedit_controller.dart';

class AdresseditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdresseditController>(
      () => AdresseditController(),
    );
  }
}
