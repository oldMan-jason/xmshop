import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  // 配置状态栏透明
  SystemUiOverlayStyle statusBar =
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(statusBar);

  runApp(ScreenUtilInit(
      // 设计稿中设备的尺寸，建议dp
      designSize: const Size(1080, 2400),
      // 是否文字大小适配
      minTextAdapt: true,
      // 是否支持分屏尺寸
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          // 设置主题颜色、去除按钮点击的波纹效果
          theme: ThemeData(
            primarySwatch: Colors.grey,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
          ),

          //配置ios动画
          defaultTransition: Transition.rightToLeft,
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      }));
}
