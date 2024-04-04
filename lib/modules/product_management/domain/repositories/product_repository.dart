import '../entities/product_entity.dart';

abstract class ProductRepository {
  addProduct(ProductEntity productEntity);
  getSavedProducts();
}