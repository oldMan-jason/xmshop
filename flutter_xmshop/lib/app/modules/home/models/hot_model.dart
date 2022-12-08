class Hotlist {
  Hotlist({
    required this.result,
  });
  late final List<HotItemModel> result;

  Hotlist.fromJson(Map<String, dynamic> json) {
    result =
        List.from(json['result']).map((e) => HotItemModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['result'] = result.map((e) => e.toJson()).toList();
    return data;
  }
}

class HotItemModel {
  HotItemModel({
    required this.sid,
    required this.title,
    required this.cid,
    required this.price,
    required this.pic,
    required this.subTitle,
    required this.sPic,
  });
  late final String sid;
  late final String title;
  late final String cid;
  late final int price;
  late final String pic;
  late final String subTitle;
  late final String sPic;

  HotItemModel.fromJson(Map<String, dynamic> json) {
    sid = json['_id'];
    title = json['title'];
    cid = json['cid'];
    price = json['price'];
    pic = json['pic'];
    subTitle = json['sub_title'];
    sPic = json['s_pic'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sid;
    data['title'] = title;
    data['cid'] = cid;
    data['price'] = price;
    data['pic'] = pic;
    data['sub_title'] = subTitle;
    data['s_pic'] = sPic;
    return data;
  }
}
