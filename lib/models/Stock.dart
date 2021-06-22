import 'package:flutter/material.dart';

class Stock {
  final String id;
  final String name;

  Stock({
    @required this.id,
    @required this.name,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json['_id'],
      name: json['name'],
    );
  }
}
