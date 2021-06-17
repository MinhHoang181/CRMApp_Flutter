import 'dart:collection';
import 'package:cntt2_crm/models/PagingInfo.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/conversation_api.dart';
import 'package:flutter/material.dart';

import '../Conversation.dart';

class ConversationList extends ChangeNotifier {
  Map<String, Conversation> _list;
  PagingInfo pageInfo;

  List<Conversation> get list => _list.values.toList();
  UnmodifiableMapView get map => UnmodifiableMapView(_list);

  void _addList(List<Conversation> conversations) {
    conversations.forEach((conversation) {
      if (!_list.containsKey(conversation.id)) {
        _list[conversation.id] = conversation;
      }
    });
    notifyListeners();
  }

  Future<ConversationList> fetchData() async {
    if (_list == null) {
      _list = new Map<String, Conversation>();
      final data =
          await ConversationAPI.fetchConversationsAllPages(start: 0, min: 20);
      if (data != null) {
        _addList(data.item1);
        pageInfo = data.item2;
      }
    }
    return this;
  }

  Future<bool> refreshData() async {
    _list.clear();
    final data =
        await ConversationAPI.fetchConversationsAllPages(start: 0, min: 20);
    if (data != null) {
      _addList(data.item1);
      pageInfo = data.item2;
      return true;
    }
    return false;
  }

  Future<bool> loadMoreData() async {
    if (pageInfo.hasNextPage) {
      final data = await ConversationAPI.fetchConversationsAllPages(
          start: pageInfo.next, min: 20);
      if (data != null) {
        _addList(data.item1);
        pageInfo = data.item2;
        return true;
      }
    }
    return false;
  }
}
