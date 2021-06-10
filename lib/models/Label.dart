import 'package:flutter/material.dart';

class Label {
  final String id;
  String name;
  Color color;

  Label({
    @required this.id,
    @required this.name,
    @required this.color,
  });

  factory Label.fromJson(Map<String, dynamic> json) {
    String color = json['color'].replaceAll('#', '0xff');
    return Label(
      id: json['_id'],
      name: json['title'],
      color: Color(int.parse(color)),
    );
  }
}
