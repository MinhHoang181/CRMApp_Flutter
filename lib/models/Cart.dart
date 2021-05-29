import 'dart:collection';

import 'package:flutter/material.dart';

import 'Product.dart';

class Cart extends ChangeNotifier {
  final Map<Product, int> _products = new Map<Product, int>();

  UnmodifiableMapView get products => UnmodifiableMapView(_products);

  int getTotalQuantity() {
    int _total = 0;
    _products.forEach((key, value) {
      _total += value;
    });
    return _total;
  }

  int getTotalPrice() {
    int _total = 0;
    _products.forEach((key, value) {
      _total += key.price * value;
    });
    return _total;
  }

  int getTotalCost() {
    int feeShip = 0;
    int discount = 0;
    int _total = getTotalPrice() + feeShip - discount;
    return _total;
  }

  void add(Product product) {
    if (_products.containsKey(product)) {
      _products[product]++;
    } else {
      _products.putIfAbsent(product, () => 1);
    }
    notifyListeners();
  }

  void remove(Product product) {
    if (_products.containsKey(product)) {
      if (_products[product] <= 1) {
        _products.remove(product);
      } else {
        _products[product]--;
      }
      notifyListeners();
    }
  }

  void removeAll() {
    _products.clear();
    notifyListeners();
  }
}
