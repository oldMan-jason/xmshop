import 'package:flutter/material.dart';
import '../../../tool/screenadapter.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  UserView({Key? key}) : super(key: key);

  final List title = [
    "一键安装",
    "一键退换",
    "一键维修",
    "服务进度",
    "小米之家",
    "客服中心",
    "以旧换新",
    "手机电池"
  ];
  final List icon = [
    Icon(
      Icons.moped_rounded,
      color: Colors.blue,
    ),
    Icon(
      Icons.change_circle_rounded,
      color: Colors.orange,
    ),
    Icon(
      Icons.fire_extinguisher_rounded,
      color: Colors.purple,
    ),
    Icon(
      Icons.percent_rounded,
      color: Colors.orange,
    ),
    Icon(
      Icons.home,
      color: Colors.blue,
    ),
    Icon(
      Icons.room_service,
      color: Colors.orange,
    ),
    Icon(
      Icons.run_circle_outlined,
      color: Colors.green,
    ),
    Icon(
      Icons.battery_0_bar_outlined,
      color: Colors.green,
    ),
  ];
  List<Widget> _services() {
    return List.generate(8, (index) {
      return Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon[index],
            SizedBox(
              height: 5,
            ),
            Text(title[index])
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    print("UserView --- build");
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 244, 244),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Container(
            alignment: Alignment.center,
            child: Text(
              "退出登录",
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
              onPressed: () {
                if (controller.loginState.value) {
                  controller.loginOut();
                }
              },
              icon: Icon(Icons.login_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.qr_code)),
          IconButton(onPressed: () {}, icon: Icon(Icons.message_rounded))
        ],
      ),
      body: Obx(() {
        return ListView(
          children: [
            // 登录头像设置
            Container(
              padding: EdgeInsets.only(left: 20),
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    child: CircleAvatar(
                      backgroundImage:
                          const AssetImage("assets/images/user.png"),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        if (!controller.loginState.value) {
                          // 登录
                          Get.toNamed("/signin");
                        }
                      },
                      child: Text(
                        controller.loginState.value
                            ? controller.user.value.username!
                            : "登录/注册",
                        style: TextStyle(fontSize: 20, color: Colors.black87),
                      )),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: controller.loginState.value
                        ? Colors.grey[400]
                        : Colors.transparent,
                    size: 16,
                  )
                ],
              ),
            ),
            // 分类信息设置
            Container(
              height: 80,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "--",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "米金",
                            style: TextStyle(
                                color: Colors.grey[350],
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "--",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "优惠券",
                            style: TextStyle(
                                color: Colors.grey[350],
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "--",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "红包",
                            style: TextStyle(
                                color: Colors.grey[350],
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "--",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "最高额度",
                            style: TextStyle(
                                color: Colors.grey[350],
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bookmarks_outlined),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "钱包",
                            style: TextStyle(
                                color: Colors.grey[350],
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ))
                ],
              ),
            ),
            // 广告1
            Container(
              padding: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  alignment: Alignment.center,
                  width: ScreenAdpater.getScreenWidth() - 20,
                  height: 125,
                  child: Image.asset(
                    "assets/images/user_ad1.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // 订单信息
            Container(
              margin: EdgeInsets.all(10),
              height: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                children: [
                  Container(
                    height: 44,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "收藏",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black45,
                          ),
                        ),
                        Container(
                          color: Colors.yellow,
                          height: 35,
                          width: 1,
                        ),
                        Text(
                          "足迹",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black45,
                          ),
                        ),
                        Container(
                          color: Colors.yellow,
                          height: 35,
                          width: 1,
                        ),
                        Text(
                          "关注",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Divider(
                      color: Colors.grey[300],
                      height: 2,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.bookmarks_outlined, color: Colors.black87),
                          Text("待付款", style: TextStyle(color: Colors.black87))
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.car_crash, color: Colors.black87),
                          Text("待收货", style: TextStyle(color: Colors.black87))
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.design_services_outlined,
                              color: Colors.black87),
                          Text("退换/售后", style: TextStyle(color: Colors.black87))
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.copy_all_rounded, color: Colors.black87),
                          Text("全部订单", style: TextStyle(color: Colors.black87))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            // 服务信息
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              margin: EdgeInsets.all(10),
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "服务",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text("查看更多 >",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 186, 174, 174))))
                    ],
                  ),
                  GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    childAspectRatio: 1 / 1,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    crossAxisCount: 4,
                    children: _services(),
                  )
                ],
              ),
            ),
            // 广告2
            Container(
              width: double.infinity,
              height: 130,
              margin: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/user_ad2.png",
                        ),
                        fit: BoxFit.contain)),
              ),
            )
          ],
        );
      }),
    );
  }
}
