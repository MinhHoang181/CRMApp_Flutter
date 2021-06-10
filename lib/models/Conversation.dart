import 'dart:collection';

import 'package:cntt2_crm/utilities/datetime.dart';
import 'package:flutter/material.dart';

class Participant {
  final String id;
  final String name;

  Participant({
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
      conversations.add(Conversation.fromJson(value));
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
  final String pageId;
  final List<Participant> participants;

  String snippet;
  String updatedTime;
  bool isRead;
  bool isReplied;
  List<String> labelIds;
  bool hasNode;
  bool hasOrder;
  bool hasPhone;

  Conversation({
    @required this.id,
    @required this.pageId,
    @required this.participants,
    @required this.snippet,
    @required this.updatedTime,
    @required this.isRead,
    @required this.isReplied,
    this.labelIds,
    this.hasNode = false,
    this.hasOrder = false,
    this.hasPhone = false,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    List<dynamic> users = json['participants'];
    List<dynamic> labels = json['label_ids'];
    List<Participant> participants = List.empty(growable: true);
    users.forEach((element) {
      participants.add(Participant(
        id: element['_id'],
        name: element['name'],
      ));
    });
    List<String> labelIds = List.empty(growable: true);
    labels.forEach((element) {
      labelIds.add(element);
    });
    final updatedTime = readTimestamp(json['updated_time']);

    return Conversation(
      id: json['id'],
      pageId: json['page_id'],
      participants: participants,
      snippet: json['snippet'],
      updatedTime: updatedTime,
      isRead: json['is_read'],
      isReplied: json['is_replied'],
      labelIds: labelIds,
      hasNode: json['has_node'] != null ? json['has_node'] : false,
      hasOrder: json['has_order'] != null ? json['has_order'] : false,
      hasPhone: json['has_phone'] != null ? json['has_phone'] : false,
    );
  }
}
