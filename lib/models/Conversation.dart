import 'dart:collection';

import 'package:cntt2_crm/models/Paging/MessagePage.dart';
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

class Conversation extends ChangeNotifier {
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

  final MessagePage messages;

  Conversation({
    @required this.id,
    @required this.pageId,
    @required this.participants,
    @required this.snippet,
    @required this.updatedTime,
    @required this.isRead,
    @required this.isReplied,
    @required this.messages,
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
      id: json['_id'],
      pageId: json['page_id'],
      participants: participants,
      snippet: json['snippet'],
      updatedTime: updatedTime,
      isRead: json['is_read'],
      isReplied: json['is_replied'],
      messages: new MessagePage(conversationId: json['_id']),
      labelIds: labelIds,
      hasNode: json['has_node'] != null ? json['has_node'] : false,
      hasOrder: json['has_order'] != null ? json['has_order'] : false,
      hasPhone: json['has_phone'] != null ? json['has_phone'] : false,
    );
  }
}
