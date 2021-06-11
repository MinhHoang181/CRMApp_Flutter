import 'dart:collection';

import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/ChatMessage.dart';
import 'package:cntt2_crm/models/Paging/PagingInfo.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service.dart';
import 'package:flutter/material.dart';

class MessagePage extends ChangeNotifier {
  final String conversationId;
  final Map<String, ChatMessage> _list = new Map<String, ChatMessage>();
  PagingInfo pageInfo;

  MessagePage({
    @required this.conversationId,
  });

  UnmodifiableMapView get list => UnmodifiableMapView(_list);

  Future<MessagePage> fetchData() async {
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
