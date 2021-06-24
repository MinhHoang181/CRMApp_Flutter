import 'package:flutter/material.dart';

class Attribute {
  final String name;
  final String value;

  Attribute({
    @required this.name,
    @required this.value,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      name: json['name'],
      value: json['value'],
    );
  }
}
