import 'package:flutter/material.dart';

class Transport {
  final String id;
  final String name;
  final bool isActive;

  Transport({
    @required this.id,
    @required this.name,
    @required this.isActive,
  });

  factory Transport.fromJson(Map<String, dynamic> json) {
    return Transport(
      id: json['_id'],
      name: json['name'],
      isActive: json['is_active'],
    );
  }
}
