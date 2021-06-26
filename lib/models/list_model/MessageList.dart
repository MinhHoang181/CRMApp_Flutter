import 'dart:collection';

import 'package:cntt2_crm/models/ChatMessage.dart';
import 'package:cntt2_crm/models/PageInfo.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/message_api.dart';
import 'package:flutter/material.dart';

class MessageList extends ChangeNotifier {
  final String conversationId;
  final String pageId;
  final String recipentId;
  Map<String, ChatMessage> _list;
  Queue<ChatMessage> _unUpdateList = new Queue<ChatMessage>();
  PagingInfo pageInfo;

  MessageList({
    @required this.conversationId,
    @required this.pageId,
    @required this.recipentId,
  });

  UnmodifiableMapView get map => UnmodifiableMapView(_list);
  List<ChatMessage> get list {
    List<ChatMessage> chatlog = _unUpdateList.toList();
    chatlog.addAll(_list.values);
    return chatlog;
  }

  // List<ChatMessage> _sortTime(List<ChatMessage> sortList) {
  //   sortList.sort((a, b) {
  //     final dayA = a.timeCreated;
  //     final dayB = b.timeCreated;
  //     return dayB.compareTo(dayA);
  //   });
  //   return sortList;
  // }

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
      _unUpdateList.any((element) {
        if (element.id == message.id) {
          _unUpdateList.remove(element);
          return true;
        }
        return false;
      });
      final temp = <String, ChatMessage>{
        message.id: message,
      };
      temp.addAll(_list);
      _list = temp;
      notifyListeners();
      return true;
    } else {
      _list[message.id].update(message);
      notifyListeners();
      return true;
    }
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

  Future<bool> sendMessage(ChatMessage message) async {
    _unUpdateList.addFirst(message);
    notifyListeners();
    String id = await MessageAPI.sendMessage(
      pageId: this.pageId,
      recipientId: this.recipentId,
      message: message,
    );
    if (id != null) {
      message.id = id;
      add(message);
      return true;
    } else {
      _unUpdateList.remove(message);
      notifyListeners();
      return false;
    }
  }
}
