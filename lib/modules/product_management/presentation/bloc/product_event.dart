part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class CheckAddProduct extends ProductEvent{}


class ProductAddEvent extends ProductEvent {
  final ProductEntity productEntity ;
  ProductAddEvent({required this.productEntity});
  @override
  List<Object> get props => [productEntity];
}

class ProductListEvent extends ProductEvent{

  @override
  List<Object> get props => [];
}

class ProductDetailsEvent extends ProductEvent{

  @override
  List<Object> get props => [];
}

class ProductSearchEvent extends ProductEvent{
 final String word;

 ProductSearchEvent({required this.word});
 
}