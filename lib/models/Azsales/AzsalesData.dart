import 'dart:collection';

import 'package:cntt2_crm/models/list_model/ConversationList.dart';
import 'package:cntt2_crm/models/Facebook/FacebookPage.dart';
import 'package:cntt2_crm/models/Azsales/AzsalesAccount.dart';
import 'package:cntt2_crm/models/list_model/LabelList.dart';
import 'package:cntt2_crm/models/list_model/ReplyList.dart';
import 'package:flutter/material.dart';

class AzsalesData extends ChangeNotifier {
  static AzsalesData _instance = AzsalesData._();

  String azsalesAccessToken;
  AzsalesAccount azsalesAccount = new AzsalesAccount();

  final LabelList labels = new LabelList();
  final ReplyList replies = new ReplyList();
  final Map<String, FacebookPage> _pages = new Map<String, FacebookPage>();

  //Chat - Conversation
  final ConversationList conversations = new ConversationList();

  static AzsalesData get instance => _instance;
  UnmodifiableMapView get pages => UnmodifiableMapView(_pages);

  //SINGLETON
  AzsalesData._();

  //AZSALESACCOUNT
  void updateAzsalesAccount(AzsalesAccount account) {
    azsalesAccount = account;
    notifyListeners();
  }

  //FACEBOOKPage
  void loadPages(List<FacebookPage> pages) {
    _pages.clear();
    pages.forEach((element) {
      _pages[element.id] = element;
    });
    notifyListeners();
  }

  void addPage(FacebookPage page) {
    if (!_pages.containsKey(page.id)) {
      _pages[page.id] = page;
      notifyListeners();
    }
  }
}
