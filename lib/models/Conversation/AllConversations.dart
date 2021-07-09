import 'dart:collection';

import 'package:cntt2_crm/models/Conversation/Conversation.dart';
import 'package:cntt2_crm/models/Conversation/Conversations.dart';
import 'package:cntt2_crm/models/Conversation/FilterConversation.dart';
import 'package:cntt2_crm/models/PageInfo.dart';
import 'package:cntt2_crm/models/list_model/ConversationList.dart';
import 'package:cntt2_crm/models/list_model/FilterConversationList.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/conversation_api.dart';

class AllConversations extends Conversations {
  Map<FilterConversation, Map<String, Conversation>> _list =
      Map<FilterConversation, Map<String, Conversation>>();
  Map<FilterConversation, PagingInfo> _pageInfo =
      Map<FilterConversation, PagingInfo>();

  FilterConversationList _filters = FilterConversationList();

  int get unreadCount => _list.values.first.values
      .where((conversation) => conversation.isRead == false)
      .length;

  AllConversations(ConversationList root) : super(root);

  @override
  UnmodifiableMapView get map => UnmodifiableMapView(_list.values.first);

  @override
  PagingInfo get pageInfo => _pageInfo.values.first;

  @override
  PagingInfo pageFilter(FilterConversation filterConversation) {
    return _pageInfo[filterConversation];
  }

  @override
  FilterConversationList get filters => _filters;

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
  Future<bool> searchData(
      FilterConversation filterConversation, String search) async {
    final data = await ConversationAPI.fetchConversations(
      start: 0,
      filter: filterConversation.copyWith(search: search),
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
  bool addConversation(
      FilterConversation filterConversation, Conversation conversation) {
    if (!_list.values.first.containsKey(conversation.id)) {
      _list.values.first[conversation.id] = conversation;
    } else {
      conversation = _list.values.first[conversation.id];
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
