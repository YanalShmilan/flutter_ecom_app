import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductsRepository {
  final List<Product> _products = kTestProducts;

  List<Product> getProductList() {
    return _products;
  }

  Product? getProductById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<List<Product>> fetchProductsList() async {
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductsList() {
    return Stream.value(_products);
  }

  Stream<Product> watchProduct(String id) {
    return Stream.value(_products.firstWhere((product) => product.id == id));
  }

  Future<Product> fetchProductById(String id) {
    return Future.value(_products.firstWhere((product) => product.id == id));
  }
}

final productRepositoryProvider = Provider.autoDispose<FakeProductsRepository>((ref) {
  return FakeProductsRepository();
});

final productListStreamProvider = StreamProvider.autoDispose<List<Product>>((ref) {
  return ref.watch(productRepositoryProvider).watchProductsList();
});


final productListFutureProvider = FutureProvider.autoDispose<List<Product>>((ref) {
  return ref.watch(productRepositoryProvider).fetchProductsList();
});


final productByIdProvider = StreamProvider.autoDispose.family<Product, String>((ref,id) {
  return ref.watch(productRepositoryProvider).watchProduct(id);
});