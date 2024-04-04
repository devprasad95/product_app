import 'package:dartz/dartz.dart';
import 'package:product_app/core/internet_connection/internet_connection_status.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/product_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImp implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;
  final InternetConnectionStatus networkInfo;

  ProductRepositoryImp(
      {required this.networkInfo, required this.productRemoteDataSource});

  @override
  addProduct(ProductEntity productEntity) async {
    if (!await networkInfo.isConnected) {
      return Left(OfflineFailure());
    } else {
      try {
        final docId = await productRemoteDataSource.getDocs();
        final productModel = ProductModel(
          name: productEntity.name,
          measurement: productEntity.measurement,
          price: productEntity.price,
          productNo: docId.toString(),
        );
        final product = await productRemoteDataSource.addProduct(productModel);
        return Right(product);
      } on WeekPassWordException {
        return Left(WeekPassWordFailure());
      } on AlreadyExistingAccountException {
        return Left(AlreadyExistingAccountFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  getSavedProducts() async {
    if (!await networkInfo.isConnected) {
      return Left(OfflineFailure());
    } else {
      try {
        productRemoteDataSource.getDocs();
        final product = await productRemoteDataSource.savedProductsList();
        final data = product.docs.map((doc) => doc.data()).toList();
        return Right(data.map((e) => ProductModel.fromJson(e)).toList());
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }
}