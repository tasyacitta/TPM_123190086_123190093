import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prak_b_123190086_123190093/api/model/products_model.dart';

class BaseNetwork {
  static final String baseUrl = "https://makeup-api.herokuapp.com/api/v1/products.json";

  static Future<Map<String, dynamic>> get(String partUrl) async {
    final String fullUrl = baseUrl + "/" + partUrl;
    debugPrint("BaseNetwork - fullUrl : $fullUrl");
    final response = await http.get(Uri.parse(fullUrl));
    debugPrint("BaseNetwork - response : ${response.body}");
    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> _processResponse(
      http.Response response) async {
    final body = response.body;
    if (body.isNotEmpty) {
      final jsonBody = json.decode(body);
      return jsonBody;
    } else {
      print("processResponse error");
      return {"error": true};
    }
  }

  static Future<List<ProductsModel>> getMakeup(String partUrl) async {
    final String fullUrl = baseUrl + partUrl;
    // debugPrint("BaseNetwork - fullUrl : $fullUrl");

    final response = await http.get(Uri.parse(fullUrl));
    debugPrint("BaseNetwork - response : ${response.body}");

    return _processResponseMakeup(response);
  }
  static Future<List<ProductsModel>> _processResponseMakeup(
      http.Response response) async {
    final body = response.body;
    final jsonBody = json.decode(body);
    return jsonBody.map<ProductsModel>((r) => ProductsModel.fromJson(r)).toList();
  }

  static void debugPrint(String value) {
    print("[BASE_NETWORK] - $value");
  }
}