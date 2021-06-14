import 'package:cntt2_crm/providers/azsales_api/chat_service/reply_api.dart';
import 'package:flutter/material.dart';

class QuickReply extends ChangeNotifier {
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

  void _update(QuickReply reply) {
    this.text = reply.text;
    this.shortcut = reply.shortcut;
    notifyListeners();
  }

  Future<bool> update(String shortcut, String text) async {
    QuickReply reply = await ReplyAPI.updateReply(
      id: this.id,
      shortcut: shortcut,
      text: text,
    );
    if (reply != null) {
      if (this.id == reply.id) {
        _update(reply);
        return true;
      }
    }
    return false;
  }
}
