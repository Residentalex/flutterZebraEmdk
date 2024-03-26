import 'dart:convert';

import 'package:flutter_zebra_emdk/src/data/models/company_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CompanyRepository extends GetxController {
  static CompanyRepository get instance => Get.find();

  Future<CompanyModel> get({required String token, required String url}) async {
    try {
      final apiUrl = Uri.parse('$url/datasnap/rest/tds/check_price_params');

      var response = await http.get(apiUrl,
          headers: {'Content-Type': 'application/json', 'Token': token});

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var company = CompanyModel.fromJson(body);
        return company;
      } else {
        throw response.statusCode.toString();
      }
    } catch (e) {
      throw 'Error: $e';
    }
  }
}
