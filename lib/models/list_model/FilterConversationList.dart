import 'dart:collection';

import 'package:cntt2_crm/models/Conversation/FilterConversation.dart';

class FilterConversationList {
  Map<String, FilterConversation> _filters;

  FilterConversationList({
    List<String> pageIds,
  }) {
    _filters = <String, FilterConversation>{
      'Tất cả': FilterConversation(
        pageIds: pageIds,
      ),
      'Chưa xem': FilterConversation(
        pageIds: pageIds,
        isRead: false,
      ),
      'Chưa trả lời': FilterConversation(
        pageIds: pageIds,
        isReplied: false,
      ),
    };
  }

  UnmodifiableMapView get map => UnmodifiableMapView(_filters);

  FilterConversation get({
    int filterId,
    String filterName,
  }) {
    if (filterId != null) {
      return _filters.values.elementAt(filterId);
    } else if (filterName != null && _filters.containsKey(filterName)) {
      return _filters[filterName];
    }
    return null;
  }
}
