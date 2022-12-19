// 收件地址
class AddressModel {
  String? name;
  String? tel;
  String? address;
  String? detail;
  bool? isdefl;
  int? id;

  AddressModel(
      {this.name, this.tel, this.address, this.detail, this.isdefl, this.id});

  AddressModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    tel = json["tel"];
    address = json["address"];
    detail = json["detail"];
    isdefl = json["isdefl"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['tel'] = tel;
    data['address'] = address;
    data['detail'] = detail;
    data['isdefl'] = isdefl;
    data['id'] = id;
    return data;
  }
}
