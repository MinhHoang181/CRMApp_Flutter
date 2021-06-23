import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/list_model/CustomerList.dart';
import 'package:cntt2_crm/models/list_model/MessageList.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/conversation_api.dart';
import 'package:cntt2_crm/utilities/datetime.dart';
import 'package:flutter/material.dart';

import '../list_model/NoteList.dart';
import '../list_model/OrderList.dart';

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
  String dateUpdate;
  int timeUpdate;
  bool isRead;
  bool isReplied;
  List<String> labelIds;
  bool hasNote;
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
    @required this.timeUpdate,
    @required this.dateUpdate,
    @required this.isRead,
    @required this.isReplied,
    @required this.messages,
    @required this.notes,
    @required this.orders,
    @required this.customers,
    @required this.labelIds,
    this.hasNote = false,
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
    final dateUpdate = readTimestamp(json['updated_time']);
    return Conversation(
      id: json['_id'],
      pageId: json['page_id'],
      participants: participants,
      snippet: json['snippet'],
      timeUpdate: json['updated_time'],
      dateUpdate: dateUpdate,
      isRead: json['is_read'],
      isReplied: json['is_replied'],
      messages: new MessageList(
        conversationId: json['_id'],
        pageId: json['page_id'],
        recipentId: participants[0].id,
      ),
      notes: new NoteList(conversationId: json['_id']),
      orders: new OrderList(conversationId: json['_id']),
      customers: new CustomerList(conversationId: json['_id']),
      labelIds: labelIds,
      hasNote: json['has_note'] != null ? json['has_note'] : false,
      hasOrder: json['has_order'] != null ? json['has_order'] : false,
      hasPhone: json['has_phone'] != null ? json['has_phone'] : false,
    );
  }

  bool update(Conversation conversation) {
    this.snippet = conversation.snippet;
    this.dateUpdate = conversation.dateUpdate;
    this.isRead = conversation.isRead;
    this.isReplied = conversation.isReplied;
    this.labelIds = conversation.labelIds;
    if (conversation.hasNote != null) this.hasNote = conversation.hasNote;
    if (conversation.hasOrder != null) this.hasOrder = conversation.hasOrder;
    if (conversation.hasPhone != null) this.hasPhone = conversation.hasPhone;

    if (this.timeUpdate != conversation.timeUpdate) {
      notifyListeners();
      this.timeUpdate = conversation.timeUpdate;
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }

  void updateRead(bool isRead) {
    this.isRead = isRead;
    notifyListeners();
  }

  void _updateLabels(List<String> labelIds) {
    this.labelIds = labelIds;
    notifyListeners();
  }

  Future<Conversation> fetchData() async {
    messages.fetchData();
    notes.fetchData().then((value) {
      this.hasNote = value.map.isNotEmpty;
      notifyListeners();
    });
    orders.fetchData().then((value) {
      this.hasOrder = value.map.isNotEmpty;
      notifyListeners();
    });
    customers.fetchData().then((value) {
      this.hasPhone = value.map.isNotEmpty;
      notifyListeners();
    });
    return this;
  }

  Future<bool> setLabel(String labelId) async {
    List<String> labelIds = await ConversationAPI.setLabel(
        conversationId: this.id, labelId: labelId);
    if (labelIds != null) {
      bool success = await ConversationAPI.notifyConversationChanged(
          conversationId: this.id);
      if (!success) {
        _updateLabels(labelIds);
      }
      return true;
    }
    return false;
  }

  Future<bool> unsetLabel(String labelId) async {
    List<String> labelIds = await ConversationAPI.unsetLabel(
        conversationId: this.id, labelId: labelId);
    if (labelIds != null) {
      bool success = await ConversationAPI.notifyConversationChanged(
          conversationId: this.id);
      if (!success) {
        _updateLabels(labelIds);
      }
      return true;
    }
    return false;
  }
}
