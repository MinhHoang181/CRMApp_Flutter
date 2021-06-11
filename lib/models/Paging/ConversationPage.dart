import 'dart:collection';
import 'package:cntt2_crm/models/Paging/PagingInfo.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service.dart';
import 'package:flutter/material.dart';

import '../Conversation.dart';

class ConversationPage extends ChangeNotifier {
  Map<String, Conversation> _list;
  PagingInfo pageInfo;

  UnmodifiableMapView get list => UnmodifiableMapView(_list);

  Future<ConversationPage> fetchData() async {
    if (_list == null) {
      _list = new Map<String, Conversation>();
      return fetchConversationsAllPages(start: 0, min: 20);
    } else {
      return this;
    }
  }

  Future<bool> refreshData() async {
    _list.clear();
    await fetchConversationsAllPages(start: 0, min: 20);
    return _list.isEmpty ? false : true;
  }

  Future<bool> loadMoreData() async {
    if (pageInfo.hasNextPage) {
      final count = _list.length;
      await fetchConversationsAllPages(start: pageInfo.next, min: 20);
      return count < _list.length ? true : false;
    }
    return false;
  }

  void add(Conversation conversation) {
    if (!_list.containsKey(conversation.id)) {
      _list[conversation.id] = conversation;
      notifyListeners();
    }
  }
}
