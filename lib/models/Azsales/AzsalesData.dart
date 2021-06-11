import 'dart:collection';

import 'package:cntt2_crm/models/Paging/ConversationPage.dart';
import 'package:cntt2_crm/models/Label.dart';
import 'package:cntt2_crm/models/Facebook/FacebookPage.dart';
import 'package:cntt2_crm/models/QuickReply.dart';
import 'package:cntt2_crm/models/Azsales/AzsalesAccount.dart';
import 'package:flutter/material.dart';

class AzsalesData extends ChangeNotifier {
  static AzsalesData _instance = AzsalesData._();

  String azsalesAccessToken;
  AzsalesAccount azsalesAccount = new AzsalesAccount();

  final Map<String, Label> _labes = new Map<String, Label>();
  final Map<String, QuickReply> _replies = new Map<String, QuickReply>();
  final Map<String, FacebookPage> _pages = new Map<String, FacebookPage>();

  //Chat - Conversation
  final ConversationPage conversations = new ConversationPage();

  static AzsalesData get instance => _instance;
  UnmodifiableMapView get labels => UnmodifiableMapView(_labes);
  UnmodifiableMapView get replies => UnmodifiableMapView(_replies);
  UnmodifiableMapView get pages => UnmodifiableMapView(_pages);

  //SINGLETON
  AzsalesData._();

  //LABEL
  void loadLabels(List<Label> labels) {
    _labes.clear();
    labels.forEach((element) {
      _labes[element.id] = element;
    });
    notifyListeners();
  }

  void addLabel(Label label) {
    if (!_labes.containsKey(label.id)) {
      _labes[label.id] = label;
      notifyListeners();
    }
  }

  //REPLIES
  void addReply(QuickReply reply) {
    if (!_replies.containsKey(reply.id)) {
      _replies[reply.id] = reply;
      notifyListeners();
    }
  }

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
