import 'dart:collection';

import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/list_model/CustomerList.dart';
import 'package:cntt2_crm/models/list_model/MessageList.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/conversation_api.dart';
import 'package:cntt2_crm/utilities/datetime.dart';
import 'package:flutter/material.dart';

import 'list_model/NoteList.dart';
import 'list_model/OrderList.dart';

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

  final MessageList messages;
  final NoteList notes;
  final OrderList orders;
  final CustomerList customers;

  Conversation({
    @required this.id,
    @required this.pageId,
    @required this.participants,
    @required this.snippet,
    @required this.updatedTime,
    @required this.isRead,
    @required this.isReplied,
    @required this.messages,
    @required this.notes,
    @required this.orders,
    @required this.customers,
    @required this.labelIds,
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
      if (AzsalesData.instance.labels.map.containsKey(element)) {
        labelIds.add(element);
      }
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
      messages:
          new MessageList(conversationId: json['_id'], pageId: json['page_id']),
      notes: new NoteList(conversationId: json['_id']),
      orders: new OrderList(conversationId: json['_id']),
      customers: new CustomerList(conversationId: json['_id']),
      labelIds: labelIds,
      hasNode: json['has_node'] != null ? json['has_node'] : false,
      hasOrder: json['has_order'] != null ? json['has_order'] : false,
      hasPhone: json['has_phone'] != null ? json['has_phone'] : false,
    );
  }

  void update(Conversation conversation) {
    this.snippet = conversation.snippet;
    this.updatedTime = conversation.updatedTime;
    this.isRead = conversation.isRead;
    this.isReplied = conversation.isReplied;
    this.labelIds = conversation.labelIds;
    this.hasNode = conversation.hasNode;
    this.hasOrder = conversation.hasOrder;
    this.hasPhone = conversation.hasPhone;
    notifyListeners();
  }

  void _updateLabels(List<String> labelIds) {
    this.labelIds = labelIds;
    notifyListeners();
  }

  Future<bool> setLabel(String labelId) async {
    List<String> labelIds = await ConversationAPI.setLabel(
        conversationId: this.id, labelId: labelId);
    if (labelIds != null) {
      _updateLabels(labelIds);
      return true;
    }
    return false;
  }

  Future<bool> unsetLabel(String labelId) async {
    List<String> labelIds = await ConversationAPI.unsetLabel(
        conversationId: this.id, labelId: labelId);
    if (labelIds != null) {
      _updateLabels(labelIds);
      return true;
    }
    return false;
  }
}
