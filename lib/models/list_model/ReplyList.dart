import 'dart:collection';

import 'package:cntt2_crm/models/QuickReply.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/reply_api.dart';
import 'package:flutter/material.dart';

class ReplyList extends ChangeNotifier {
  Map<String, QuickReply> _list;
  UnmodifiableMapView get map => UnmodifiableMapView(_list);
  List<QuickReply> get list => _list.values.toList();

  void _addList(List<QuickReply> replies) {
    replies.forEach((reply) {
      if (!_list.containsKey(reply.id)) {
        _list[reply.id] = reply;
      }
    });
    notifyListeners();
  }

  bool _addReply(QuickReply reply) {
    if (!_list.containsKey(reply.id)) {
      _list[reply.id] = reply;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<ReplyList> fetchData() async {
    if (_list == null) {
      _list = new Map<String, QuickReply>();
      final replies = await ReplyAPI.fetchAllReplies();
      if (replies != null) {
        _addList(replies);
      }
    }
    return this;
  }

  Future<bool> refreshData() async {
    final replies = await ReplyAPI.fetchAllReplies();
    if (replies != null) {
      _list.clear();
      _addList(replies);
      return true;
    }
    return false;
  }

  Future<bool> createReply(String shortcut, String text) async {
    QuickReply reply = await ReplyAPI.createReply(
      shortcut: shortcut,
      text: text,
    );
    if (reply != null) {
      final check = _addReply(reply);
      return check;
    }
    return false;
  }
}
