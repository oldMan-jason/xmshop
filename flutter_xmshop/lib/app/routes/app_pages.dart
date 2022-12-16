import 'package:get/get.dart';

import '../modules/login/code/bindings/code_binding.dart';
import '../modules/login/code/views/code_view.dart';
import '../modules/login/register/bindings/register_binding.dart';
import '../modules/login/register/views/register_view.dart';
import '../modules/login/registeroff/bindings/registeroff_binding.dart';
import '../modules/login/registeroff/views/registeroff_view.dart';
import '../modules/login/signin/bindings/signin_binding.dart';
import '../modules/login/signin/views/signin_view.dart';
import '../modules/productdetail/bindings/productdetail_binding.dart';
import '../modules/productdetail/views/productdetail_view.dart';
import '../modules/productlist/bindings/productlist_binding.dart';
import '../modules/productlist/views/productlist_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/tabs/bindings/tabs_binding.dart';
import '../modules/tabs/views/tabs_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.TABS;

  static final routes = [
    GetPage(
      name: _Paths.TABS,
      page: () => const TabsView(),
      binding: TabsBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTLIST,
      page: () => const ProductlistView(),
      binding: ProductlistBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTDETAIL,
      page: () => const ProductdetailView(),
      binding: ProductdetailBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => const SigninView(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.CODE,
      page: () => const CodeView(),
      parameters: {},
      binding: CodeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTEROFF,
      page: () => const RegisteroffView(),
      binding: RegisteroffBinding(),
    ),
  ];
}
