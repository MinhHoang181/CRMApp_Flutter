import 'dart:collection';

import 'package:cntt2_crm/models/Product/Variant.dart';
import 'package:flutter/material.dart';

import 'Product/Product.dart';

class Cart extends ChangeNotifier {
  final Map<Variant, int> _products = new Map<Variant, int>();

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
    _products.forEach((variant, number) {
      _total += variant.finalPrice * number;
    });
    return _total;
  }

  int getTotalCost() {
    int feeShip = 0;
    int discount = 0;
    int _total = getTotalPrice() + feeShip - discount;
    return _total;
  }

  void add(Variant variant) {
    if (_products.containsKey(variant)) {
      if (variant.total > _products[variant]) {
        _products[variant]++;
      }
    } else {
      _products.putIfAbsent(variant, () => 1);
    }
    notifyListeners();
  }

  void remove(Variant variant) {
    if (_products.containsKey(variant)) {
      if (_products[variant] <= 1) {
        _products.remove(variant);
      } else {
        _products[variant]--;
      }
      notifyListeners();
    }
  }

  void removeAll() {
    _products.clear();
    notifyListeners();
  }

  int totalSelectOfProduct(Product product) {
    int total = 0;
    product.variants.map.values.forEach((variant) {
      if (products.containsKey(variant)) {
        total += products[variant];
      }
    });
    return total;
  }
}
