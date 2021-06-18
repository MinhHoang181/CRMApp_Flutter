import 'package:cntt2_crm/models/list_model/ConversationList.dart';
import 'package:cntt2_crm/models/Azsales/AzsalesAccount.dart';
import 'package:cntt2_crm/models/list_model/FacebookPageList.dart';
import 'package:cntt2_crm/models/list_model/LabelList.dart';
import 'package:cntt2_crm/models/list_model/ReplyList.dart';
import 'package:flutter/material.dart';

class AzsalesData extends ChangeNotifier {
  static AzsalesData _instance = AzsalesData._();

  String azsalesAccessToken;
  AzsalesAccount azsalesAccount = new AzsalesAccount();

  final LabelList labels = new LabelList();
  final ReplyList replies = new ReplyList();
  final FacebookPageList pages = new FacebookPageList();

  //Chat - Conversation
  final ConversationList conversations = new ConversationList();

  static AzsalesData get instance => _instance;

  //SINGLETON
  AzsalesData._();

  Future<AzsalesData> fetchData() async {
    //pages
    pages.fetchData();
    //labels
    labels.fetchData();
    //QuickReplies
    replies.fetchData();
    //Conversations
    conversations.fetchData();
    return this;
  }

  //AZSALESACCOUNT
  void updateAzsalesAccount(AzsalesAccount account) {
    azsalesAccount = account;
    notifyListeners();
  }
}
