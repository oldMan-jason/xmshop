import 'package:flutter_screenutil/flutter_screenutil.dart';

/**
 *  屏幕适配封装类
 */

class ScreenAdpater {
  static width(num v) {
    return v.w;
  }

  static height(num v) {
    return v.h;
  }

  static fontSize(num v) {
    return v.sp;
  }

  static getScreenWidth() {
    return ScreenUtil().screenWidth;
  }

  static getScreenHeight() {
    return ScreenUtil().screenHeight;
  }
}
