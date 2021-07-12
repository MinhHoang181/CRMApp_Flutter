import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:flutter/material.dart';

class FacebookPage {
  final String id;
  final String name;
  final String imageUrl;
  bool _isSelected = true;
  bool get isSelected => _isSelected;

  FacebookPage({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
  });

  factory FacebookPage.fromJson(Map<String, dynamic> json) {
    final String id = json['_id'];
    final String imageUrl = 'https://graph.facebook.com/$id/picture';
    return FacebookPage(
      id: id,
      name: json['name'],
      imageUrl: imageUrl,
    );
  }

  void toggleSelect({bool select}) {
    if (select != null) {
      _isSelected = select;
    } else {
      _isSelected = _isSelected ? false : true;
    }
    AzsalesData.instance.pages.notify(this);
  }
}
