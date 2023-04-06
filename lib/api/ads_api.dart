import 'package:gasapp/constants/constants.dart';
import 'package:gasapp/model/ads_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<List<AdsModel>> adsApi() async {
  try {
    var url = Uri.parse(linkAds);
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var body = convert.json.decode(response.body);
      Iterable list = body;

      List<AdsModel> adsModel = list.map((e) => AdsModel.fromJson(e)).toList();

      return adsModel;
    }
  } catch (e) {
    throw Exception(e);
  }
  return [];
}
