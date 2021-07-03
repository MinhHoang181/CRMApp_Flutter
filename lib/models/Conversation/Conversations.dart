import 'dart:collection';

import 'package:cntt2_crm/models/Conversation/Conversation.dart';
import 'package:cntt2_crm/models/Conversation/FilterConversation.dart';
import 'package:cntt2_crm/models/PageInfo.dart';
import 'package:cntt2_crm/models/list_model/ConversationList.dart';
import 'package:flutter/material.dart';

abstract class Conversations extends ChangeNotifier {
  final ConversationList root;

  Conversations(this.root);

  UnmodifiableMapView get map;
  PagingInfo get pageInfo;
  PagingInfo pageFilter(FilterConversation filterConversation);

  List<Conversation> list(FilterConversation filterConversation);

  List<Conversation> sortTime(List<Conversation> sortList) {
    sortList.sort((a, b) {
      final dayA = a.timeUpdate;
      final dayB = b.timeUpdate;
      return dayB.compareTo(dayA);
    });
    return sortList;
  }

  Future<Conversations> fetchData(FilterConversation filterConversation);
  Future<bool> refreshData(FilterConversation filterConversation);
  Future<bool> loadMoreData(FilterConversation filterConversation);

  bool addConversation(
      FilterConversation filterConversation, Conversation conversation);

  Future<bool> refreshAll();
}
