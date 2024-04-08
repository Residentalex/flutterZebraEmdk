import 'package:flutter_zebra_emdk/src/data/models/company_model.dart';
import 'package:flutter_zebra_emdk/src/repositories/company_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../widget/toast/loaders.dart';

class CompanyController extends GetxController {
  static CompanyController get instance => Get.find();

  final localStorage = GetStorage();
  final companyRepository = Get.put(CompanyRepository());

  RxString imageUrl = ''.obs;

  @override
  void onInit() async {
    var company = await getCompany();
    imageUrl.value = company.bgImage ?? '';
    super.onInit();
  }

  Future<CompanyModel> getCompany(
      {String apitoken = '', String apiurl = ''}) async {
    try {
      String token =
          apitoken.isEmpty ? localStorage.read('TOKEN') ?? '' : apitoken;
      String url = apiurl.isEmpty ? localStorage.read('APIURL') ?? '' : apiurl;

      if (url.isEmpty || token.isEmpty) {
        return CompanyModel();
      }

      final company = await companyRepository.get(token: token, url: url);
      company.bgImage = '$url/${company.bgImage}';
      return company;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Ups. Verifique los datos suministrados.');
      return CompanyModel();
    }
  }
}
