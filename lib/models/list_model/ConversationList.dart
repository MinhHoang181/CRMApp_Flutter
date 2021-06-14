import 'dart:collection';
import 'package:cntt2_crm/models/PagingInfo.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/conversation_api.dart';
import 'package:flutter/material.dart';

import '../Conversation.dart';

class ConversationList extends ChangeNotifier {
  Map<String, Conversation> _list;
  PagingInfo pageInfo;

  UnmodifiableListView get list => UnmodifiableListView(_list.values.toList());
  UnmodifiableMapView get map => UnmodifiableMapView(_list);

  bool add(Conversation conversation) {
    if (!_list.containsKey(conversation.id)) {
      _list[conversation.id] = conversation;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<ConversationList> fetchData() async {
    if (_list == null) {
      _list = new Map<String, Conversation>();
      return ConversationAPI.fetchConversationsAllPages(start: 0, min: 20);
    } else {
      return this;
    }
  }

  Future<bool> refreshData() async {
    _list.clear();
    await ConversationAPI.fetchConversationsAllPages(start: 0, min: 20);
    return true;
  }

  Future<bool> loadMoreData() async {
    if (pageInfo.hasNextPage) {
      final count = _list.length;
      await ConversationAPI.fetchConversationsAllPages(
          start: pageInfo.next, min: 20);
      return count < _list.length ? true : false;
    }
    return false;
  }
}
