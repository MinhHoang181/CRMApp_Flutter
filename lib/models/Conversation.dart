import 'package:flutter/material.dart';

class Conversations {
  final pageId;
  List<Conversation> list = List.empty(growable: true);

  Conversations({
    @required this.pageId,
  });

  factory Conversations.fromJson(String pageId, List<dynamic> json) {
    Conversations conversations = new Conversations(pageId: pageId);
    json.forEach((value) {
      conversations.list.add(Conversation.fromJson(pageId, value));
    });
    return conversations;
  }
}

class Conversation {
  final String id;
  final String snippet;
  final String pageId;
  final String userId;
  final String updateTime;
  final int undreadCount;
  final bool isSender;

  Conversation({
    @required this.id,
    @required this.pageId,
    @required this.userId,
    @required this.snippet,
    @required this.updateTime,
    @required this.undreadCount,
    @required this.isSender,
  });

  factory Conversation.fromJson(String pageId, Map<String, dynamic> json) {
    List<dynamic> tags = json['messages']['data'][0]['tags']['data'];
    bool isSender = false;
    String userId;
    tags.forEach((element) {
      if (element['name'] == 'sent') {
        isSender = true;
      }
    });
    userId = isSender
        ? json['messages']['data'][0]['to']['id']
        : json['messages']['data'][0]['from']['id'];
    return Conversation(
      id: json['id'],
      pageId: pageId,
      userId: userId,
      snippet: json['snippet'],
      updateTime: json['update_time'],
      undreadCount: json['unread_count'],
      isSender: isSender,
    );
  }
}
