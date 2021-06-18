import 'dart:collection';
import 'package:cntt2_crm/models/ChatMessage.dart';
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
    conversations.forEach((conversation) async {
      if (!_list.containsKey(conversation.id)) {
        _list[conversation.id] = await conversation.fetchData();
      }
    });
    notifyListeners();
  }

  void listenUpdate(Conversation conversation) {
    if (_list.containsKey(conversation.id)) {
      _list[conversation.id].update(conversation);
    }
  }

  void listenUpdateRead(String conversationId, bool isRead) {
    if (_list.containsKey(conversationId)) {
      _list[conversationId].updateRead(isRead);
    }
  }

  void listenReceiveMessage(String conversationId, ChatMessage message) {
    if (_list.containsKey(conversationId)) {
      _list[conversationId].messages.add(message);
    }
  }

  String getPageId(String conversationId) {
    if (_list.containsKey(conversationId)) {
      print(_list[conversationId].pageId);
      return _list[conversationId].pageId;
    } else {
      return '';
    }
  }

  Future<ConversationList> fetchData() async {
    if (_list == null) {
      _list = new Map<String, Conversation>();
      ConversationAPI.listenChangeConversation(conversations: this);
      ConversationAPI.listenIsReadChanged(conversations: this);
      ConversationAPI.listenMessageChanged(conversationList: this);
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
    final data =
        await ConversationAPI.fetchConversationsAllPages(start: 0, min: 20);
    if (data != null) {
      _list.clear();
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
