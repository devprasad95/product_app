import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/product_model.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class ProductCase {
  final ProductRepository repository;

  ProductCase(this.repository);

  call(ProductEntity productEntity) async {
    return await repository.addProduct(productEntity);
  }

   Future<Either<Failure, List<ProductModel>>> calling() async {
    return await repository.getSavedProducts();
  }
}