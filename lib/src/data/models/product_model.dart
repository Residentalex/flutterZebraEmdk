class ProductModel {
  String? code;
  String? reference;
  String? manufacturerReference;
  String? name;
  double? price;

  ProductModel(
      {this.code,
      this.reference,
      this.manufacturerReference,
      this.name,
      this.price});

  ProductModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    reference = json['reference'];
    manufacturerReference = json['manufacturer_reference'];
    name = json['name'];
    price = json['price'] + 0.0;
  }
}
