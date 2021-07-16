import 'dart:collection';
import 'package:cntt2_crm/models/Customer.dart';
import 'package:cntt2_crm/models/Order/Order.dart';
import 'package:cntt2_crm/models/Order/StatusOrder.dart';
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

  Future<bool> updateOrder() async {
    if (_idOrder == null) return false;
    final order = await OrderAPI.updateOrder(idOrder: _idOrder, cart: this);
    if (order != null) {
      if (_order != null) {
        _order.update(order);
      }
      return true;
    }
    return false;
  }

  Future<bool> confirmOrder() async {
    if (_idOrder == null) return false;
    final check = await OrderAPI.confirmOrder(idOrder: _idOrder);
    if (check != null && check && _order != null) {
      _order.updateStatus(StatusOrder.confirmedOrder);
    }
    return check;
  }

  Future<bool> receiveOrder() async {
    if (_idOrder == null) return false;
    final check = await OrderAPI.receiveOrder(idOrder: _idOrder);
    if (check != null && check && _order != null) {
      _order.updateStatus(StatusOrder.confirmedOrder);
    }
    return check;
  }

  Future<bool> returningOrder() async {
    if (_idOrder == null) return false;
    final check = await OrderAPI.returningOrder(idOrder: _idOrder);
    if (check != null && check && _order != null) {
      _order.updateStatus(StatusOrder.confirmedOrder);
    }
    return check;
  }

  Future<bool> returnOrder() async {
    if (_idOrder == null) return false;
    final check = await OrderAPI.returnOrder(idOrder: _idOrder);
    if (check != null && check && _order != null) {
      _order.updateStatus(StatusOrder.confirmedOrder);
    }
    return check;
  }

  Future<bool> cancelOrder() async {
    if (_idOrder == null) return false;
    final check = await OrderAPI.cancelOrder(idOrder: _idOrder);
    if (check != null && check && _order != null) {
      _order.updateStatus(StatusOrder.cancelOrder);
    }
    return check;
  }

  void updateFromOrder(Order order) {
    _order = order;
    _idOrder = order.id;
    customer.copy(order.customer);
    _address.copy(order.address);
    mimeType = order.type.code;
    stock = order.stock;
    _recipientName = order.recipientName;
    _recipientPhone = order.recipientPhone;
    _externalNote = order.externalNote;
    _internalNote = order.internalNote;
    _bank = order.bankPaymen;
    _card = order.cardPaymen;
    _other = order.otherPaymen;
    _discount = order.discount;
    initStatus = order.status.code;
    _products.clear();
    order.products.forEach((element) {
      final product = Product(
        id: element.id,
        name: element.name,
      );
      final variant = Variant(
        product: product,
        id: element.variantId,
        barcode: null,
        price: element.price,
        inPrice: null,
        salePrice: null,
        attributes: element.attributes,
        total: -1,
      );
      _products[variant] = element.quantity;
    });
  }

  factory Cart.fromOrder(Order order) {
    return Cart()
      ..updateFromOrder(order)
      ..canEdit = false;
  }

  Order _order;
  String _idOrder;
  int mimeType = 2;
  int whoReceive;
  final String conversationId;
  final Customer customer = Customer();
  int initStatus = 0;
  bool _canEdit = true;
  bool get canEdit {
    if (initStatus < 3) return _canEdit && true;
    return false;
  }

  set canEdit(bool value) {
    _canEdit = value;
    updateFromOrder(_order);
    notifyListeners();
  }

  final Map<Variant, int> _products = Map<Variant, int>();
  UnmodifiableMapView get products => UnmodifiableMapView(_products);

  Stock stock;
  final Address _address = Address();
  Address get address => mimeType != 1 ? _address : null;

  String _recipientName = '';
  String get recipientName =>
      (_recipientName != null && _recipientName.isNotEmpty)
          ? _recipientName
          : null;
  set recipientName(String name) {
    _recipientName = name;
  }

  String _recipientPhone = '';
  String get recipientPhone =>
      (_recipientPhone != null && _recipientPhone.isNotEmpty)
          ? _recipientPhone
          : null;
  set recipientPhone(String phone) {
    _recipientPhone = phone;
  }

  String _externalNote = '';
  String get externalNote => (_externalNote != null && _externalNote.isNotEmpty)
      ? _externalNote
      : null;
  set externalNote(String note) {
    _externalNote = note;
  }

  String _internalNote = '';
  String get internalNote => (_internalNote != null && _internalNote.isNotEmpty)
      ? _internalNote
      : null;
  set internalNote(String note) {
    _internalNote = note;
  }

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
      if (variant.total > _products[variant] || variant.total == -1) {
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

  String get cartItemsJson {
    String cartItems = '';
    _products.forEach((variant, total) {
      cartItems += _itemToJson(variant);
    });
    return '[' + cartItems + ']';
  }
}
