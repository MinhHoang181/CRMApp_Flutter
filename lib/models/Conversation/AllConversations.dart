import 'dart:collection';

import 'package:cntt2_crm/models/Conversation/Conversation.dart';
import 'package:cntt2_crm/models/Conversation/Conversations.dart';
import 'package:cntt2_crm/models/Conversation/FilterConversation.dart';
import 'package:cntt2_crm/models/PageInfo.dart';
import 'package:cntt2_crm/models/list_model/ConversationList.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/conversation_api.dart';

class AllConversations extends Conversations {
  Map<FilterConversation, Map<String, Conversation>> _list = Map.fromIterable(
    FilterConversation.list,
    key: (filter) => filter,
    value: (_) => null,
  );
  Map<FilterConversation, PagingInfo> _pageInfo =
      <FilterConversation, PagingInfo>{
    FilterConversation.all: PagingInfo(hasNextPage: false, next: 1, start: 1),
  };

  AllConversations(ConversationList root) : super(root);

  @override
  UnmodifiableMapView get map =>
      UnmodifiableMapView(_list[FilterConversation.all]);

  @override
  PagingInfo get pageInfo => _pageInfo[FilterConversation.all];

  @override
  PagingInfo pageFilter(FilterConversation filterConversation) {
    return _pageInfo[filterConversation];
  }

  @override
  List<Conversation> list(FilterConversation filterConversation) {
    final sortList = _list[filterConversation].values.toList();
    return sortTime(sortList);
  }

  void _addList(
      FilterConversation filterConversation, List<Conversation> conversations) {
    conversations.forEach((conversation) {
      addConversation(filterConversation, conversation);
    });
    notifyListeners();
  }

  @override
  Future<AllConversations> fetchData(
      FilterConversation filterConversation) async {
    if (_list[filterConversation] == null) {
      _list[filterConversation] = Map<String, Conversation>();
      final data = await ConversationAPI.fetchConversations(
        start: 0,
        filter: filterConversation,
      );
      if (data != null) {
        _addList(filterConversation, data.item1);
        _pageInfo[filterConversation] = data.item2;
      }
    }
    return this;
  }

  @override
  Future<bool> refreshData(FilterConversation filterConversation) async {
    final data = await ConversationAPI.fetchConversations(
      start: 0,
      filter: filterConversation,
    );
    if (data != null) {
      _list[filterConversation].clear();
      _addList(filterConversation, data.item1);
      _pageInfo[filterConversation] = data.item2;
      return true;
    }
    return false;
  }

  @override
  Future<bool> loadMoreData(FilterConversation filterConversation) async {
    if (_pageInfo[filterConversation].hasNextPage) {
      final data = await ConversationAPI.fetchConversations(
        start: pageInfo.next,
        filter: filterConversation,
      );
      if (data != null) {
        _addList(filterConversation, data.item1);
        _pageInfo[filterConversation] = data.item2;
        return true;
      }
    }
    return false;
  }

  @override
  bool addConversation(
      FilterConversation filterConversation, Conversation conversation) {
    if (!_list[FilterConversation.all].containsKey(conversation.id)) {
      _list[FilterConversation.all][conversation.id] = conversation;
    } else {
      conversation = _list[FilterConversation.all][conversation.id];
    }
    if (!_list[filterConversation].containsKey(conversation.id)) {
      _list[filterConversation][conversation.id] = conversation;
      return true;
    }
    return false;
  }

  @override
  Future<bool> refreshAll() async {
    await Future.forEach(
      _list.keys,
      (filter) => refreshData(filter),
    );
    notifyListeners();
    return true;
  }
}
