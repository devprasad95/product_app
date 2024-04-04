import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel(
      {required super.name,
      required super.measurement,
      required super.price,
      required super.productNo});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        name: json['Name'] ?? "",
        measurement: json['Measurement'] ?? "",
        price: json['Price'] ?? "",
        productNo: json["Product_no"].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Measurement': measurement,
      'Price': price,
      'Product_no': productNo
    };
  }
}