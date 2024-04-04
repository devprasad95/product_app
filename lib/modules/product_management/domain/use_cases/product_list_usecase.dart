import '../repositories/product_repository.dart';

class ProductListUseCase {
  final ProductRepository repository;

  ProductListUseCase(this.repository);

   call() async {
    return await repository.getSavedProducts();
  }
}