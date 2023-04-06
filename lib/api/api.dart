import 'package:gasapp/constants/constants.dart';
import 'package:gasapp/model/request_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<List<ResponseModel>> apiRequest({
  required GazRequestModel gazRequestModel,
}) async {
  try {
    var url = Uri.parse(link);
    http.Response response = await http.post(
      url,
      body: gazRequestModel.toJson(),
    );

    if (response.statusCode == 200) {
      var body = convert.json.decode(response.body);
      Iterable list = body;

      List<ResponseModel> responseModel =
          list.map((e) => ResponseModel.fromJson(e)).toList();

      return responseModel;
    }
  } catch (e) {
    throw Exception(e);
  }
  return [];
}
