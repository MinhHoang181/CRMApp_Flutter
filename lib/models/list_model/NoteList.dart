import 'dart:collection';

import 'package:cntt2_crm/models/Note.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/note_api.dart';
import 'package:flutter/material.dart';

class NotePagingInfo {
  bool hasNextPage = false;
  int currentPage = 1;

  NotePagingInfo({
    @required this.hasNextPage,
    @required this.currentPage,
  });

  factory NotePagingInfo.fromJson(Map<String, dynamic> json) {
    return NotePagingInfo(
      hasNextPage: json['hasNextPage'],
      currentPage: json['currentPage'],
    );
  }
}

class NoteList extends ChangeNotifier {
  final String conversationId;
  NotePagingInfo pageInfo;
  Map<String, Note> _list;

  NoteList({@required this.conversationId});

  UnmodifiableMapView get map => UnmodifiableMapView(_list);
  UnmodifiableListView get list => UnmodifiableListView(_list.values.toList());

  void _addList(List<Note> notes) {
    notes.forEach((note) {
      if (!_list.containsKey(note.id)) {
        _list[note.id] = note;
      }
    });
    notifyListeners();
  }

  Future<NoteList> fetchData() async {
    if (_list == null) {
      _list = new Map<String, Note>();
      final data = await NoteAPI.fetchNotesOfConversation(
          conversationId: this.conversationId);
      _addList(data.item1);
      pageInfo = data.item2;
    }
    return this;
  }

  Future<bool> refreshData() async {
    _list.clear();
    final data = await NoteAPI.fetchNotesOfConversation(
        conversationId: this.conversationId);
    _addList(data.item1);
    this.pageInfo = data.item2;
    return true;
  }

  Future<bool> loadMoreData() async {
    if (pageInfo.hasNextPage) {
      final count = _list.length;
      final data = await NoteAPI.fetchNotesOfConversation(
        conversationId: this.conversationId,
        page: pageInfo.currentPage + 1,
      );
      _addList(data.item1);
      this.pageInfo = data.item2;
      return count < _list.length ? true : false;
    }
    return false;
  }
}
