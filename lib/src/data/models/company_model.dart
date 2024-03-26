class CompanyModel {
  String? companyId;
  String? companyName;
  String? phoneNumber;
  String? address;
  String? identification;
  String? bgImage;

  CompanyModel(
      {this.companyId,
      this.companyName,
      this.phoneNumber,
      this.address,
      this.identification,
      this.bgImage});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    companyId = json['company_id'];
    companyName = json['company_name'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    identification = json['identification'];
    bgImage = json['bg_image'];
  }
}
