import 'package:get/get.dart';

import '../controllers/tabs_controller.dart';

import '../../home/controllers/home_controller.dart';
import '../../category/controllers/category_controller.dart';
import '../../service/controllers/service_controller.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../user/controllers/user_controller.dart';

class TabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabsController>(
      () => TabsController(),
    );

    // home数据共享
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    // 分类数据共享
    Get.lazyPut<CategoryController>(
      () => CategoryController(),
    );

    // 服务数据共享
    Get.lazyPut<ServiceController>(
      () => ServiceController(),
    );

    // 购物车数据共享
    Get.lazyPut<CartController>(
      () => CartController(),
    );

    // 用户数据共享
    Get.lazyPut<UserController>(
      () => UserController(),
    );
  }
}
