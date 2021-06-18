import 'dart:collection';

import 'package:cntt2_crm/models/Facebook/FacebookPage.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/facebookpage_api.dart';
import 'package:flutter/material.dart';

class FacebookPageList extends ChangeNotifier {
  Map<String, FacebookPage> _list;
  UnmodifiableMapView get map => UnmodifiableMapView(_list);

  void _addList(List<FacebookPage> pages) {
    pages.forEach((page) {
      if (!_list.containsKey(page.id)) {
        _list[page.id] = page;
      }
    });
    notifyListeners();
  }

  Future<FacebookPageList> fetchData() async {
    if (_list == null) {
      _list = new Map<String, FacebookPage>();
      final pages = await FacebookPageAPI.fetchAllPages();
      if (pages != null) {
        _addList(pages);
      }
    }
    return this;
  }
}
