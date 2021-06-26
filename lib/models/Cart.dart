import 'dart:collection';

import 'package:cntt2_crm/models/Customer.dart';
import 'package:cntt2_crm/models/Product/Variant.dart';
import 'package:cntt2_crm/models/Stock.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/order_api.dart';
import 'package:flutter/material.dart';

import 'Location/Address.dart';
import 'Product/Product.dart';

class Cart extends ChangeNotifier {
  Cart({
    this.conversationId,
    Customer customer,
  }) {
    if (customer != null) {
      this.customer.copy(customer);
      _address.copy(customer.address);
    }
  }

  Future<bool> createOrder() async {
    final order = await OrderAPI.createOrder(cart: this);
    if (order != null) {
      return true;
    }
    return false;
  }

  int mimeType = 2;
  int whoReceive;
  final String conversationId;
  final Customer customer = Customer();
  String get cartItemsJson {
    String cartItems = '';
    _products.forEach((variant, total) {
      cartItems += _itemToJson(variant);
    });
    return '[' + cartItems + ']';
  }

  final Map<Variant, int> _products = Map<Variant, int>();
  UnmodifiableMapView get products => UnmodifiableMapView(_products);

  Stock stock;
  final Address _address = Address();
  Address get address => mimeType != 1 ? _address : null;

  String _recipientName = '';
  String get recipientName => _recipientName.isNotEmpty ? _recipientName : null;
  set recipientName(String name) {
    _recipientName = name;
  }

  String _recipientPhone = '';
  String get recipientPhone =>
      _recipientPhone.isNotEmpty ? _recipientPhone : null;
  set recipientPhone(String phone) {
    _recipientPhone = phone;
  }

  String _externalNote = '';
  String get externalNote => _externalNote.isNotEmpty ? _externalNote : null;
  set externalNote(String note) {
    _externalNote = note;
  }

  String _internalNote = '';
  String get internalNote => _internalNote.isNotEmpty ? _internalNote : null;
  set internalNote(String note) {
    _internalNote = note;
  }

  int initStatus = 1;

  int _discount = 0;
  int get discount => _discount;
  set discount(int value) {
    _discount = value;
    notifyListeners();
  }

  int _bank = 0;
  int get bank => _bank;
  set bank(int value) {
    _bank = value;
    notifyListeners();
  }

  int _card = 0;
  int get card => _card;
  set card(int value) {
    _card = value;
    notifyListeners();
  }

  int _other = 0;
  int get other => _other;
  set other(int value) {
    _other = value;
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
    double _total = totalPrice - discount - bank - card - other;
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

  String _itemToJson(Variant variant) {
    return '''
    {
      product_id_ref: "${variant.product.id}"
      variant_id: ${variant.id}
      qty: ${_products[variant]}
    }
    ''';
  }
}
