import 'dart:convert';

import 'package:flutter_zebra_emdk/src/data/models/product_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  Future<ProductModel> get(
      {required String code,
      required String token,
      required String url}) async {
    try {
      final apiUrl = Uri.parse('$url/check_price/$code');

      var response = await http.get(apiUrl,
          headers: {'Content-Type': 'application/json', 'Token': token});

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var product = ProductModel.fromJson(body);
        return product;
      } else {
        throw response.statusCode.toString();
      }
    } catch (e) {
      throw 'Error: $e';
    }
  }
}
