import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:flutter/material.dart';

class FacebookPage {
  final String id;
  final String name;
  bool _isSelected = true;
  bool get isSelected => _isSelected;

  FacebookPage({
    @required this.id,
    @required this.name,
  });

  factory FacebookPage.fromJson(Map<String, dynamic> json) {
    return FacebookPage(
      id: json['_id'],
      name: json['name'],
    );
  }

  void toggleSelect() {
    _isSelected = _isSelected ? false : true;
    AzsalesData.instance.pages.notify(this);
  }
}
