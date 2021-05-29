import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final int total;
  final String sku;
  final int price;
  final String image;

  Product({
    @required this.id,
    @required this.name,
    @required this.total,
    @required this.sku,
    @required this.price,
    this.image = '',
  });
}
