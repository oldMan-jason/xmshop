import 'package:get/get.dart';

import '../controllers/registeroff_controller.dart';

class RegisteroffBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisteroffController>(
      () => RegisteroffController(),
    );
  }
}
