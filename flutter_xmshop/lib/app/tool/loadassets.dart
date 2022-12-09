import 'package:flutter/material.dart';

// 加载本地图片
class LoadAssetsImage {
  static ImageProvider<Object> loadProviderImage(String imageName) {
    return AssetImage("assets/images/$imageName.png");
  }

  static Image loadAssetsName(String name) {
    return Image.asset("assets/images/$name.png", fit: BoxFit.cover);
  }
}
