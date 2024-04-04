part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddProduct extends ProductState {}

class Loadingstate extends ProductState {}

class ProductListState extends ProductState {
  final List products;

  ProductListState({required this.products});
}

class ProductDetailsState extends ProductState {
  final ProductModel productModel;

  ProductDetailsState({required this.productModel});
}

class ErrorProductState extends ProductState {
  final String message;
  ErrorProductState({required this.message});
  @override
  List<Object> get props => [message];
}