import 'dart:collection';

import 'package:cntt2_crm/models/Facebook/FacebookPage.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/facebookpage_api.dart';

class FacebookPageList {
  Map<String, FacebookPage> _list;
  UnmodifiableMapView get map => UnmodifiableMapView(_list);
  List<String> get pageIds => List.generate(
        _list.values.length,
        (index) => _list.values.elementAt(index).id,
      );
  List<String> selectedPageIds = List.empty(growable: true);

  void notify(FacebookPage page) {
    if (page.isSelected && !selectedPageIds.contains(page.id)) {
      selectedPageIds.add(page.id);
    } else if (!page.isSelected) {
      selectedPageIds.remove(page.id);
    }
  }

  void _addList(List<FacebookPage> pages) {
    pages.forEach((page) {
      if (!_list.containsKey(page.id)) {
        _list[page.id] = page;
        if (!selectedPageIds.contains(page.id)) {
          selectedPageIds.add(page.id);
        }
      }
    });
  }

  Future<FacebookPageList> fetchData() async {
    if (_list == null) {
      _list = new Map<String, FacebookPage>();
      final pages = await FacebookPageAPI.fetchAllPages();
      selectedPageIds.add("");
      if (pages != null) {
        _addList(pages);
      }
    }
    return this;
  }

  bool isAllSelected({List<String> selectList}) {
    bool check = true;
    if (selectList != null) {
      _list.forEach((id, page) {
        if (!selectList.contains(id)) {
          check = false;
          return;
        }
      });
    } else {
      _list.forEach((id, page) {
        if (!selectedPageIds.contains(id)) {
          check = false;
          return;
        }
      });
    }
    return check;
  }

  void toggleAllPage(List<String> selectList) {
    _list.forEach((id, page) {
      if (selectList.contains(id)) {
        _list[id].toggleSelect(select: true);
      } else {
        _list[id].toggleSelect(select: false);
      }
    });
  }

  void selectAllPage() {
    _list.forEach((id, page) {
      page.toggleSelect(select: true);
    });
  }

  void unselectAllPage() {
    _list.forEach((id, page) {
      page.toggleSelect(select: false);
    });
  }
}
