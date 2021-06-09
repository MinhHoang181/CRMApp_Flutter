import 'package:flutter/material.dart';

class PageFacebook {
  final String id;
  final String name;

  PageFacebook({
    @required this.id,
    @required this.name,
  });

  factory PageFacebook.fromJson(Map<String, dynamic> json) {
    return PageFacebook(
      id: json['_id'],
      name: json['name'],
    );
  }
}
