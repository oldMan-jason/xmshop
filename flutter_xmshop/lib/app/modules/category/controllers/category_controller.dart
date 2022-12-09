import 'package:get/get.dart';
import '../../../tool/httpclient.dart';
import '../../home/models/cate_model.dart';

class CategoryController extends GetxController {
  late HttpClient httpClient = HttpClient();
  RxList<CateItemModel> leftList = <CateItemModel>[].obs;
  RxList<CateItemModel> rightList = <CateItemModel>[].obs;
  RxInt selectIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadLeftListData();
  }

  changeCategoryByIndex(int index) {
    selectIndex.value = index;
    CateItemModel item = leftList[index];
    _loadRightListData(item.sId!);
    update();
  }

  _loadLeftListData() async {
    var response = await httpClient.get("api/pcate");
    leftList.value = CateModel.fromJson(response.data).result!;

    CateItemModel first = leftList.first;
    _loadRightListData(first.sId!);
    update();
  }

  _loadRightListData(String pid) async {
    var response = await httpClient.get("api/pcate", arguments: {"pid": pid});
    rightList.value = CateModel.fromJson(response.data).result!;
    update();
  }
}
