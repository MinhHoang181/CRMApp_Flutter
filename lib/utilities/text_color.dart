import 'package:flutter/material.dart';

String colorToString(Color color) {
  String text = color.toString();
  text = text
      .split('(')[1]
      .split(')')[0]
      .replaceAll('0xff', '#')
      .replaceAll(" ", "");
  return text;
}

Color stringToColor(String text) {
  String color = text.replaceAll('#', '0xff');
  int value = int.parse(color);
  return value != null ? Color(value) : Colors.white.withOpacity(0);
}
