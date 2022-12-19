// 收件地址
class AddressModel {
  String? name;
  String? tel;
  String? address;
  String? detail;
  bool? isdefl;

  AddressModel({this.name, this.tel, this.address, this.detail, this.isdefl});

  AddressModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    tel = json["tel"];
    address = json["address"];
    detail = json["detail"];
    isdefl = json["isdefl"];
  }
}
