import 'dart:collection';
import 'package:cntt2_crm/models/ChatMessage.dart';
import 'package:cntt2_crm/models/Conversation/AllConversations.dart';
import 'package:cntt2_crm/models/Conversation/Conversations.dart';
import 'package:cntt2_crm/models/Conversation/FilterConversation.dart';
import 'package:cntt2_crm/models/Facebook/FacebookConversations.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/conversation_api.dart';
import 'package:flutter/material.dart';
import '../Conversation/Conversation.dart';

enum PlatformConversation {
  all,
  facebook,
  zalo,
}

class ConversationList extends ChangeNotifier {
  Map<PlatformConversation, Conversations> _list;

  UnmodifiableMapView get map => UnmodifiableMapView(_list);

  UnmodifiableMapView get root =>
      UnmodifiableMapView(_list[PlatformConversation.all].map);

  void listenUpdate(Conversation conversation) {
    if (root.containsKey(conversation.id)) {
      final bool check = root[conversation.id].update(conversation);
      if (check) {
        notifyListeners();
      }
    }
  }

  void listenUpdateRead(String conversationId, bool isRead) {
    if (root.containsKey(conversationId)) {
      root[conversationId].updateRead(isRead);
    }
  }

  void listenReceiveMessage(String conversationId, ChatMessage message) {
    if (root.containsKey(conversationId)) {
      root[conversationId].messages.add(message);
    }
  }

  Future<ConversationList> fetchData() async {
    if (_list == null) {
      _list = <PlatformConversation, Conversations>{
        PlatformConversation.all: AllConversations(this),
        PlatformConversation.facebook: FacebookConversations(this),
        PlatformConversation.zalo: null,
      };
      ConversationAPI.listenChangeConversation(conversations: this);
      ConversationAPI.listenIsReadChanged(conversations: this);
      ConversationAPI.listenMessageChanged(conversationList: this);
      await Future.forEach<Conversations>(
        _list.values,
        (conversations) {
          if (conversations != null) {
            conversations.fetchData(FilterConversation.all);
          }
        },
      );
    }
    return this;
  }

  String getPageId(String conversationId) {
    if (map.containsKey(conversationId)) {
      return map[conversationId].pageId;
    } else {
      return '';
    }
  }

  bool addConversation(Conversation conversation) {
    final all = _list[PlatformConversation.all] as AllConversations;
    return all.addConversation(FilterConversation.all, conversation);
  }
}
