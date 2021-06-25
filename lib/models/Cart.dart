import 'dart:collection';

import 'package:cntt2_crm/models/Product/Variant.dart';
import 'package:flutter/material.dart';

import 'Product/Product.dart';

class Cart extends ChangeNotifier {
  final Map<Variant, int> _products = new Map<Variant, int>();
  UnmodifiableMapView get products => UnmodifiableMapView(_products);
  int _discount = 0;
  int get discount => _discount;
  set discount(int value) {
    _discount = value;
    notifyListeners();
  }

  int _transfer = 0;
  int get transfer => _transfer;
  set transfer(int value) {
    _transfer = value;
    notifyListeners();
  }

  int _payment = 0;
  int get payment => _payment;
  set payment(int value) {
    _transfer = value;
    notifyListeners();
  }

  int _another = 0;
  int get another => _another;
  set another(int value) {
    _another = value;
    notifyListeners();
  }

  int get totalQuantity {
    int _total = 0;
    _products.forEach((key, value) {
      _total += value;
    });
    return _total;
  }

  double get totalPrice {
    double _total = 0;
    _products.forEach((variant, number) {
      _total += variant.finalPrice * number;
    });
    return _total;
  }

  double get totalCost {
    double _total = totalPrice - discount - transfer - payment - another;
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

  void delete(Variant variant) {
    if (_products.containsKey(variant)) {
      _products.remove(variant);
      notifyListeners();
    }
  }

  void removeAll() {
    _products.clear();
    notifyListeners();
  }

  int totalSelectOfProduct(Product product) {
    int total = 0;
    if (_products.isEmpty) return 0;
    _products.forEach((variant, number) {
      if (variant.product == product) {
        total += number;
      }
    });
    return total;
  }
}
