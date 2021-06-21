import 'package:cntt2_crm/models/Product/Attribute.dart';
import 'package:flutter/material.dart';

class Variant {
  final int id;
  final String barcode;
  final int price;
  final int inPrice;
  final int salePrice;
  final List<Attribute> attributes;

  Variant({
    @required this.id,
    @required this.barcode,
    @required this.price,
    @required this.inPrice,
    @required this.salePrice,
    @required this.attributes,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    List<dynamic> attributesJson = json['attributes'];
    List<Attribute> attributes = List.empty(growable: true);
    attributesJson.forEach((attribute) {
      attributes.add(Attribute.fromJson(attribute));
    });
    return Variant(
      id: json['id'],
      barcode: json['barcode'],
      price: json['price'],
      inPrice: json['in_price'],
      salePrice: json['sale_price'],
      attributes: attributes,
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
