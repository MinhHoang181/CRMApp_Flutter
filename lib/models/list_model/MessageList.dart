import 'dart:collection';

import 'package:cntt2_crm/models/ChatMessage.dart';
import 'package:cntt2_crm/models/PagingInfo.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/message_api.dart';
import 'package:flutter/material.dart';

class MessageList extends ChangeNotifier {
  final String conversationId;
  final String pageId;
  Map<String, ChatMessage> _list;
  PagingInfo pageInfo;

  MessageList({
    @required this.conversationId,
    @required this.pageId,
  });

  UnmodifiableMapView get map => UnmodifiableMapView(_list);
  List<ChatMessage> get list => _list.values.toList();

  void _addList(List<ChatMessage> messages) {
    messages.forEach((message) {
      if (!_list.containsKey(message.id)) {
        _list[message.id] = message;
      }
    });
    notifyListeners();
  }

  bool add(ChatMessage message) {
    if (!_list.containsKey(message.id)) {
      final temp = <String, ChatMessage>{
        message.id: message,
      };
      temp.addAll(_list);
      _list = temp;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<MessageList> fetchData() async {
    if (_list == null) {
      _list = new Map<String, ChatMessage>();
      final data = await MessageAPI.fetchMessages(
          conversationId: this.conversationId, pageId: this.pageId);
      if (data != null) {
        _addList(data.item1);
        pageInfo = data.item2;
      }
    }
    return this;
  }

  Future<bool> loadMoreData() async {
    if (pageInfo.hasNextPage) {
      final data = await MessageAPI.fetchMessages(
          conversationId: this.conversationId,
          pageId: this.pageId,
          start: pageInfo.next);
      if (data != null) {
        _addList(data.item1);
        pageInfo = data.item2;
        return true;
      }
    }
    return false;
  }

  Future<bool> sendMessage() async {
    return true;
  }
}
