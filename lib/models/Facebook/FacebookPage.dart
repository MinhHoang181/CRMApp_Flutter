import 'package:flutter/material.dart';

class FacebookPage {
  final String id;
  final String name;

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
}
