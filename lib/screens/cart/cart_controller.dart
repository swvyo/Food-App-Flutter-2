import 'package:flutter/cupertino.dart';
import 'package:food_app/models/product.dart';

class CartController {
  CartController() {
    addQuantity(qtd: 1);
    addQuantity(qtd: 2);
    sumAll();
  }

  void sumAll() {
    double s = 0;
    for (int i = 0; i < this.products.length; i++) {
      s += products[i].price * quantityAt(index: i);
    }

    this.subTotal = s;
    this.total = this.subTotal;
  }

  final listProductsNotfier = ValueNotifier<List<Product>>([]);
  List<Product> get products => listProductsNotfier.value;

  void addProduct({required Product product, int quantity = 1}) {
    products.add(product);
    addQuantity(qtd: quantity);
  }

  void removeProduct({required int index}) {
    products.removeAt(index);
    removeQuantity(index: index);
  }

  // quantidades
  final quantitiesNotifier = <ValueNotifier<int>>[];

  void addQuantity({required qtd}) {
    final vn = ValueNotifier<int>(qtd);
    vn.addListener(sumAll);
    quantitiesNotifier.add(vn);
  }

  int quantityAt({required index}) => quantitiesNotifier[index].value;

  void setQuantityAt({required int index, required int newQtd}) {
    quantitiesNotifier[index].value = newQtd;
  }

  void removeQuantity({required index}) => quantitiesNotifier.removeAt(index);

  // total a pagar
  final subTotalNotifier = ValueNotifier<double>(0.0);
  double get subTotal => subTotalNotifier.value;
  set subTotal(double newSubTotal) {
    this.subTotalNotifier.value = newSubTotal;
  }

  double tax = 0.25;

  final totalNotifier = ValueNotifier<double>(0.0);
  double get total => totalNotifier.value;
  set total(double t) {
    this.totalNotifier.value = t + tax;
  }
}
