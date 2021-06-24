import 'package:flutter/material.dart';

class PageInfo {
  bool hasNextPage = false;
  int currentPage = 1;

  PageInfo({
    @required this.hasNextPage,
    @required this.currentPage,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) {
    return PageInfo(
      hasNextPage: json['hasNextPage'],
      currentPage: json['currentPage'],
    );
  }
}

class PagingInfo {
  bool hasNextPage;
  int next;
  int start;
  int min;

  PagingInfo({
    @required this.hasNextPage,
    @required this.next,
    @required this.start,
    @required this.min,
  });

  factory PagingInfo.fromJson(Map<String, dynamic> json) {
    return PagingInfo(
      hasNextPage: json['hasNextPage'],
      next: json['next'],
      start: json['start'],
      min: json['min'],
    );
  }
}
