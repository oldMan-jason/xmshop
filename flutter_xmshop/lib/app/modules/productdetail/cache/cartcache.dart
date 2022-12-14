import 'dart:convert';

import 'package:flutter_xmshop/app/modules/productdetail/models/pcontent.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class CartCacheTool {
  // 存储数据
  static Future<void> saveProduct(
      PcontentItemModel pcontent, String descVal, int count) async {
    final SharedPreferences prefs = await _prefs;
    String? cartString = await prefs.getString("cartKey");
    if (cartString != null) {
      List cartListData = json.decode(cartString);
      var hasData = cartListData.any((v) {
        return v["_id"] == pcontent.sId && v["selectedAttr"] == descVal;
      });
      if (hasData) {
        for (var i = 0; i < cartListData.length; i++) {
          if (cartListData[i]["_id"] == pcontent.sId &&
              cartListData[i]["selectedAttr"] == descVal) {
            cartListData[i]["count"] += count;
          }
        }
        await prefs.setString("cartKey", json.encode(cartListData));
      } else {
        cartListData.add({
          "_id": pcontent.sId,
          "title": pcontent.title,
          "price": pcontent.price,
          "selectedAttr": descVal,
          "count": count,
          "pic": pcontent.pic,
          "checked": true
        });
        await prefs.setString("cartKey", json.encode(cartListData));
      }
    } else {
      List<Map<String, dynamic>> tempList = [];

      tempList.add({
        "_id": pcontent.sId,
        "title": pcontent.title,
        "price": pcontent.price,
        "selectedAttr": descVal,
        "count": count,
        "pic": pcontent.pic,
        "checked": true
      });
      await prefs.setString("cartKey", json.encode(tempList));
    }
  }

  // 获取数据
  static Future<List> getCartData() async {
    final SharedPreferences prefs = await _prefs;
    String? value = prefs.getString("cartKey");
    if (value != null) {
      return json.decode(value);
    }
    return [];
  }

  static Future clearData() async {
    final SharedPreferences prefs = await _prefs;
    // prefs.remove("cartKey");
    prefs.clear();
  }
}
