import 'dart:collection';

import 'package:cntt2_crm/models/ChatMessage.dart';
import 'package:cntt2_crm/models/PagingInfo.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/querry_api.dart';
import 'package:flutter/material.dart';

class MessageList extends ChangeNotifier {
  final String conversationId;
  final Map<String, ChatMessage> _list = new Map<String, ChatMessage>();
  PagingInfo pageInfo;

  MessageList({
    @required this.conversationId,
  });

  UnmodifiableMapView get map => UnmodifiableMapView(_list);
  List<ChatMessage> get list => _list.values.toList();

  Future<MessageList> fetchData() async {
    if (_list.isEmpty) {
      return fetchMessages(conversationId: conversationId, start: 0, min: 20);
    }
    return this;
  }

  void add(ChatMessage message) {
    if (!_list.containsKey(message.id)) {
      _list[message.id] = message;
      notifyListeners();
    }
  }
}
