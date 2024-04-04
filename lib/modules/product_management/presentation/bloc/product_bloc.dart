
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constant_values.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/product_model.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/use_cases/product_list_usecase.dart';
import '../../domain/use_cases/product_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductCase productCase;
  final ProductListUseCase productListUseCase;

  List<dynamic> products = [];

  ProductBloc({required this.productListUseCase, required this.productCase})
      : super(AddProduct()) {
    on<ProductAddEvent>((event, emit) async {
      emit(Loadingstate());
      await productCase(
          event.productEntity); 
      final failureOrUserCredentiall =
          await productListUseCase(); 
      emit(ProductListState(
          products: (failureOrUserCredentiall as Right).value));
      products = failureOrUserCredentiall.value;
    });

    on<ProductListEvent>((event, emit) async {
      emit(Loadingstate());
      final failureOrUserCredential =
          await productListUseCase(); 
      emit(
          ProductListState(products: (failureOrUserCredential as Right).value));
      products = failureOrUserCredential.value;
    });

    on<ProductSearchEvent>((event, emit) async {
      emit(Loadingstate());
      List<ProductModel> productList = [];
      for (int i = 0; i < products.length; i++) {
        if (products[i].name.toLowerCase().contains(event.word.toLowerCase())) {
          productList.add(products[i]);
        }
      }
      emit(ProductListState(products: productList));
    });
  }

  ProductState eitherToState(Either either, ProductState state) {
    return either.fold(
      (failure) => ErrorProductState(message: _mapFailureToMessage(failure)),
      (_) => state,
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}