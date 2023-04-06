class AdsModel {
  String? send;
  String? images;
  String? adsimage;
  String? adslink;

  AdsModel({this.send, this.images, this.adsimage, this.adslink});

  AdsModel.fromJson(Map<String, dynamic> json) {
    send = json['send'];
    images = json['images'];
    adsimage = json['adsimage'];
    adslink = json['adslink'];
  }
}
