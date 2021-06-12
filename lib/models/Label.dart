import 'package:flutter/material.dart';
import 'package:cntt2_crm/utilities/text_color.dart';

class Label {
  final String id;
  String name;
  Color color;
  String hexColor;

  Label({
    @required this.id,
    @required this.name,
    @required this.color,
  }) {
    this.hexColor = colorToString(this.color);
  }

  factory Label.fromJson(Map<String, dynamic> json) {
    return Label(
      id: json['_id'],
      name: json['title'],
      color: stringToColor(json['color']),
    );
  }

  void update(Label label) {
    this.name = label.name;
    this.color = label.color;
    this.hexColor = label.hexColor;
  }
}
