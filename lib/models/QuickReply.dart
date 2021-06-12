import 'package:flutter/material.dart';

class QuickReply {
  final String id;
  String shortcut;
  String text;

  QuickReply({
    @required this.id,
    @required this.text,
    @required this.shortcut,
  });

  factory QuickReply.fromJson(Map<String, dynamic> json) {
    return QuickReply(
      id: json['_id'],
      text: json['text'],
      shortcut: json['shortcut'],
    );
  }
}
