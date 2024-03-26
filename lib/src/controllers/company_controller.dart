import 'package:flutter_zebra_emdk/src/data/models/company_model.dart';
import 'package:flutter_zebra_emdk/src/repositories/company_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CompanyController extends GetxController {
  static CompanyController get instance => Get.find();

  final localStorage = GetStorage();
  final companyRepository = Get.put(CompanyRepository());
  String imageUrl = '';

  @override
  void onInit() async {
    var company = await getCompany();
    imageUrl = company.bgImage!;
    super.onInit();
  }

  Future<CompanyModel> getCompany() async {
    try {
      String token = localStorage.read('TOKEN');
      String url = localStorage.read('APIURL');

      final company = await companyRepository.get(token: token, url: url);
      return company;
    } catch (e) {
      throw '$e';
    }
  }
}
