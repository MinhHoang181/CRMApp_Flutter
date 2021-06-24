import 'package:flutter/material.dart';

class Photo {
  final String id;
  final String url;

  Photo({
    @required this.id,
    @required this.url,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['_id'],
      url: json['url'],
    );
  }
}
