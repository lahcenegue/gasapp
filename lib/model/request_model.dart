class GazRequestModel {
  String? name;
  String? mobile;
  String? adress;
  String? block;
  String? street;
  String? house;
  String? counter;
  GazRequestModel(
      {this.name,
      this.mobile,
      this.adress,
      this.block,
      this.street,
      this.house,
      this.counter});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name!.trim(),
      'mobile': mobile!.trim(),
      'adress': adress!.trim(),
      'block': block!.trim(),
      'street': street!.trim(),
      'house': house!.trim(),
      'counter': counter!.trim(),
    };

    return map;
  }
}

class ResponseModel {
  String? msg;
  String? send;

  ResponseModel({
    this.msg,
    this.send,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      msg: json['msg'],
      send: json['send'],
    );
  }
}
