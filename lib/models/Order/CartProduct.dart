import 'package:flutter/material.dart';

class ProductAttriBute {
  final String name;
  final String value;

  ProductAttriBute({
    @required this.name,
    @required this.value,
  });

  factory ProductAttriBute.fromJson(Map<String, dynamic> json) {
    return ProductAttriBute(
      name: json['name'],
      value: json['value'],
    );
  }
}

class CartProduct {
  final String id;
  final String productId;
  final String name;
  final int variantId;
  int quantity;
  final int price;
  final List<ProductAttriBute> attributes;

  CartProduct({
    @required this.id,
    @required this.productId,
    @required this.name,
    @required this.variantId,
    @required this.price,
    @required this.quantity,
    @required this.attributes,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    List<dynamic> attributesJson = json['attributes'];
    List<ProductAttriBute> attributes = List.empty(growable: true);
    attributesJson.forEach((attribute) {
      attributes.add(ProductAttriBute.fromJson(attribute));
    });
    return CartProduct(
      id: json['_id'],
      productId: json['product_id_ref'],
      name: json['product_name'],
      variantId: json['variant_id'],
      price: json['price'],
      quantity: json['qty'],
      attributes: attributes,
    );
  }

  String attributesToString() {
    String text = '';
    for (var i = 0; i < attributes.length; i++) {
      text += attributes[i].name + ':' + attributes[i].value;
      if (i < attributes.length - 1) {
        text += '; ';
      }
    }
    return text;
  }
}
