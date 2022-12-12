import 'package:get/get.dart';

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
  ];
}
