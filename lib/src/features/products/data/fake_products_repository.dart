import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/models/product.dart';

class FakeProductsRepository {
  FakeProductsRepository._();
  static FakeProductsRepository instance = FakeProductsRepository._();

  final List<Product> _products = kTestProducts;

  List<Product> getProductList() {
    return _products;
  }

  Product? getProductById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<List<Product>> fetchProductsList() {
    return Future.value(_products);
  }

  Future<Product> fetchProductById(String id) {
    return Future.value(_products.firstWhere((product) => product.id == id));
  }
}