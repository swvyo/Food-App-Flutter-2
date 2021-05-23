import 'package:flutter/cupertino.dart';
import 'package:food_app/models/product.dart';

class FaveController {
  final faveProductsNotifier = ValueNotifier<List<Product>>([]);
  List<Product> get favoriteProducts => faveProductsNotifier.value;
  void addFavoriteProduct({required Product product}) {
    favoriteProducts.add(product);
  }

  void removeFavoriteProduct({required index}) {
    favoriteProducts.removeAt(index);
  }

  void removeFavoriteProductId({required id}) {
    favoriteProducts.remove(id);
  }
}
