import 'package:cntt2_crm/models/Product/Attribute.dart';
import 'package:flutter/material.dart';

import 'Product.dart';

class Variant {
  final Product product;
  final int id;
  final String barcode;
  var _price;
  double get price => _price != null ? _price.toDouble() : null;
  var _inPrice;
  double get inPrice => _inPrice != null ? _inPrice.toDouble() : null;
  var _salePrice;
  double get salePrice => _salePrice != null ? _salePrice.toDouble() : null;
  final List<Attribute> attributes;
  final int total;

  double get finalPrice => salePrice != null ? salePrice : price;

  Variant({
    @required this.product,
    @required this.id,
    @required this.barcode,
    @required price,
    @required inPrice,
    @required salePrice,
    @required this.attributes,
    @required this.total,
  }) {
    this._price = price;
    this._inPrice = inPrice;
    this._salePrice = salePrice;
  }

  factory Variant.fromJson(Product product, Map<String, dynamic> json,
      Map<String, dynamic> totalJson) {
    int id = json['id'];
    List<dynamic> attributesJson = json['attributes'];
    List<Attribute> attributes = List.empty(growable: true);
    attributesJson.forEach((attribute) {
      attributes.add(Attribute.fromJson(attribute));
    });
    int total = 0;
    if (totalJson != null) {
      if (totalJson['qty_by_variant']['$id'] != null) {
        total = totalJson['qty_by_variant']['$id']['total'];
      }
    }
    return Variant(
      product: product,
      id: id,
      barcode: json['barcode'],
      price: json['price'],
      inPrice: json['in_price'],
      salePrice: json['sale_price'],
      attributes: attributes,
      total: total,
    );
  }

  String attributesToString() {
    String text = '';
    for (var i = 0; i < attributes.length; i++) {
      text += attributes[i].name + ': ' + attributes[i].value;
      if (i < attributes.length - 1) {
        text += '; ';
      }
    }
    return text;
  }
}
