import 'dart:collection';

import 'package:cntt2_crm/models/Paging/ConversationPage.dart';
import 'package:cntt2_crm/models/Label.dart';
import 'package:cntt2_crm/models/Facebook/FacebookPage.dart';
import 'package:cntt2_crm/models/QuickReply.dart';
import 'package:cntt2_crm/models/Azsales/AzsalesAccount.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/label_api.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/querry_api.dart';
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
  bool addLabel(Label label) {
    if (!_labes.containsKey(label.id)) {
      _labes[label.id] = label;
      notifyListeners();
      return true;
    }
    return false;
  }

  bool deleteLabel(Label label) {
    if (_labes.containsKey(label.id)) {
      _labes.remove(label.id);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> refreshLabels() async {
    _labes.clear();
    bool result = await fetchAllLabels();
    return result;
  }

  Future<bool> createLabel(String name, String color) async {
    Label label = await LabelAPI.createLabel(
      labelName: name,
      labelColor: color,
    );
    if (label != null) {
      final check = addLabel(label);
      return check;
    }
    return false;
  }

  Future<bool> updateLabel(String id, String name, String color) async {
    Label label = await LabelAPI.updateLabel(
      labelId: id,
      labelName: name,
      labelColor: color,
    );
    if (label != null) {
      _labes[id] = label;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> removeLabel(String id) async {
    if (_labes.containsKey(id)) {
      bool check = await LabelAPI.removeLabel(labelId: id);
      if (check) {
        _labes.remove(id);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    }
    return false;
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
