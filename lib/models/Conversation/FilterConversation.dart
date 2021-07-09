import 'dart:collection';

class FilterConversation {
  final List<String> pageIds;
  final List<String> labeIds;
  final bool hasPhone;
  final bool hasNote;
  final bool hasOrder;
  final bool isRead;
  final bool isReplied;
  final int mimeType;
  final String search;
  final String participantId;

  const FilterConversation({
    this.pageIds,
    this.labeIds,
    this.hasPhone,
    this.hasNote,
    this.hasOrder,
    this.isRead,
    this.isReplied,
    this.mimeType,
    this.search,
    this.participantId,
  });

  factory FilterConversation.copy({
    FilterConversation filterConversation,
    List<String> pageIds,
    List<String> labeIds,
    bool hasPhone,
    bool hasNote,
    bool hasOrder,
    bool isRead,
    bool isReplied,
    int mimeType,
    String search,
    String participantId,
  }) {
    return FilterConversation(
      pageIds: pageIds == null ? filterConversation.pageIds : pageIds,
      labeIds: labeIds == null ? filterConversation.labeIds : labeIds,
      hasPhone: hasPhone == null ? filterConversation.hasPhone : hasPhone,
      hasNote: hasNote == null ? filterConversation.hasNote : hasNote,
      hasOrder: hasOrder == null ? filterConversation.hasOrder : hasOrder,
      isRead: isRead == null ? filterConversation.isRead : isRead,
      isReplied: isReplied == null ? filterConversation.isReplied : isReplied,
      mimeType: mimeType == null ? filterConversation.mimeType : mimeType,
      search: search == null ? filterConversation.search : search,
      participantId: participantId == null
          ? filterConversation.participantId
          : participantId,
    );
  }

  FilterConversation copyWith({
    FilterConversation filterConversation,
    List<String> pageIds,
    List<String> labeIds,
    bool hasPhone,
    bool hasNote,
    bool hasOrder,
    bool isRead,
    bool isReplied,
    int mimeType,
    String search,
    String participantId,
  }) {
    return FilterConversation(
      pageIds: pageIds == null ? this.pageIds : pageIds,
      labeIds: labeIds == null ? this.labeIds : labeIds,
      hasPhone: hasPhone == null ? this.hasPhone : hasPhone,
      hasNote: hasNote == null ? this.hasNote : hasNote,
      hasOrder: hasOrder == null ? this.hasOrder : hasOrder,
      isRead: isRead == null ? this.isRead : isRead,
      isReplied: isReplied == null ? this.isReplied : isReplied,
      mimeType: mimeType == null ? this.mimeType : mimeType,
      search: search == null ? this.search : search,
      participantId: participantId == null ? this.participantId : participantId,
    );
  }

  String get toGraphQL {
    String filter = '''
    $_pageIds
    $_labelIds
    $_hasPhone
    $_hasNote
    $_hasOrder
    $_isRead
    $_isReplied
    $_mimeType
    $_search
    $_participantId
    ''';
    return filter;
  }

  String get _pageIds {
    String text = '';
    if (this.pageIds != null && this.pageIds.isNotEmpty) {
      text = 'page_ids: [';
      this.pageIds.forEach((id) {
        text += '"$id",';
      });
      text += ']';
    }
    return text;
  }

  String get _labelIds {
    String text = '';
    if (this.labeIds != null && this.labeIds.isNotEmpty) {
      text = 'label_ids: [';
      this.labeIds.forEach((id) {
        text += '"$id",';
      });
      text += ']';
    }
    return text;
  }

  String get _hasPhone {
    String text = '';
    if (this.hasPhone != null) {
      text = 'has_phone: ${this.hasPhone}';
    }
    return text;
  }

  String get _hasNote {
    String text = '';
    if (this.hasNote != null) {
      text = 'has_note: ${this.hasNote}';
    }
    return text;
  }

  String get _hasOrder {
    String text = '';
    if (this.hasOrder != null) {
      text = 'has_order: ${this.hasOrder}';
    }
    return text;
  }

  String get _isRead {
    String text = '';
    if (this.isRead != null) {
      text = 'is_read: ${this.isRead}';
    }
    return text;
  }

  String get _isReplied {
    String text = '';
    if (this.isReplied != null) {
      text = 'is_replied: ${this.isReplied}';
    }
    return text;
  }

  String get _mimeType {
    String text = '';
    if (this.mimeType != null) {
      text = 'minetype: ${this.mimeType}';
    }
    return text;
  }

  String get _search {
    String text = '';
    if (this.search != null) {
      text = 'search: """${this.search}"""';
    }
    return text;
  }

  String get _participantId {
    String text = '';
    if (this.participantId != null) {
      text = 'participant_id: "${this.participantId}"';
    }
    return text;
  }
}
