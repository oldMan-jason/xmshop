import 'package:flutter/material.dart';
import 'package:flutter_xmshop/app/routes/app_pages.dart';
import 'package:get/get.dart';
import '../controllers/adresslist_controller.dart';

class AdresslistView extends GetView<AdresslistController> {
  const AdresslistView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('收获地址'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 100),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Obx(() {
                return ListView(
                  children: [
                    ...controller.adList.map((element) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              print(element.toJson());
                              // 选了当前地址'
                              controller.sureAddress(element);
                              Get.back();
                            },
                            onLongPress: () {
                              Get.defaultDialog(
                                  title: "提示信息!",
                                  middleText: "您确定要删除吗?",
                                  confirm: ElevatedButton(
                                      onPressed: () {
                                        controller.deleteData(element);
                                        Get.back();
                                      },
                                      child: const Text("确定")),
                                  cancel: ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text("取消")));
                            },
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${element.address}",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 131, 120, 120),
                                        fontSize: 13),
                                  ),
                                  Text(
                                    "${element.detail}",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17),
                                  ),
                                  Text(
                                    "${element.name} ${element.tel}",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.ADRESSEDIT,
                                        arguments: element);
                                  },
                                  icon: Icon(Icons.edit)),
                            ),
                          ),
                          Divider()
                        ],
                      );
                    }).toList(),
                  ],
                );
              })),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            height: 58,
            child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.ADRESSEDIT);
                },
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.orange,
                  child: Text(
                    "新建收获地址",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        backgroundColor: Colors.orange),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
