import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String name;
  final String measurement;
  final String price;
  final String productNo;

  const ProductEntity(
      {required this.name,
      required this.measurement,
      required this.price,
      required this.productNo});

  @override
  List<Object?> get props => [name, measurement, price, productNo];
}