import 'package:get/get.dart';

import '../controllers/code_controller.dart';

class CodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CodeController>(
      () => CodeController(),
    );
  }
}
