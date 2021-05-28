import 'dart:collection';

import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;

  User({
    @required this.id,
    @required this.name,
  });
}

class ConversationModel extends ChangeNotifier {
  final String pageId;

  final List<Conversation> _list = List.empty(growable: true);
  UnmodifiableListView<Conversation> get all => UnmodifiableListView(_list);

  ConversationModel({
    @required this.pageId,
  });

  factory ConversationModel.fromJson(String pageId, List<dynamic> json) {
    ConversationModel conversations = new ConversationModel(pageId: pageId);
    json.forEach((value) {
      conversations.add(Conversation.fromJson(pageId, value));
    });
    return conversations;
  }

  void add(Conversation conversation) {
    _list.add(conversation);
    notifyListeners();
  }

  void remove(Conversation conversation) {
    _list.remove(conversation);
    notifyListeners();
  }
}

class Conversation {
  final String id;
  final String snippet;
  final String pageId;
  final List<User> users;
  final String updateTime;
  final int undreadCount;
  final bool isSender;

  Conversation({
    @required this.id,
    @required this.pageId,
    @required this.users,
    @required this.snippet,
    @required this.updateTime,
    @required this.undreadCount,
    @required this.isSender,
  });

  factory Conversation.fromJson(String pageId, Map<String, dynamic> json) {
    List<dynamic> tags = json['messages']['data'][0]['tags']['data'];
    List<dynamic> participants = json['participants']['data'];
    bool isSender = false;
    tags.forEach((element) {
      if (element['name'] == 'sent') {
        isSender = true;
      }
    });

    List<User> users = List.empty(growable: true);
    participants.forEach((element) {
      if (element['id'] != pageId) {
        users.add(User(
          id: element['id'],
          name: element['name'],
        ));
      }
    });

    return Conversation(
      id: json['id'],
      pageId: pageId,
      users: users,
      snippet: json['snippet'],
      updateTime: json['update_time'],
      undreadCount: json['unread_count'],
      isSender: isSender,
    );
  }
}
