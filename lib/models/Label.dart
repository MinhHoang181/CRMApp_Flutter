import 'package:cntt2_crm/providers/azsales_api/chat_service/label_api.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/utilities/text_color.dart';

class Label extends ChangeNotifier {
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

  void _update(Label label) {
    this.name = label.name;
    this.color = label.color;
    this.hexColor = label.hexColor;
    notifyListeners();
  }

  Future<bool> update(String name, String color) async {
    Label label = await LabelAPI.updateLabel(
      labelId: this.id,
      labelName: name,
      labelColor: color,
    );
    if (label != null) {
      if (this.id == label.id) {
        _update(label);
        return true;
      }
    }
    return false;
  }
}
