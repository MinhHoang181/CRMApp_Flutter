import 'dart:collection';

import 'package:cntt2_crm/models/Order/Order.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/order_api.dart';
import 'package:flutter/material.dart';

class OrderPagingInfor {
  bool hasNextPage = false;
  int currentPage = 1;

  OrderPagingInfor({
    @required this.hasNextPage,
    @required this.currentPage,
  });

  factory OrderPagingInfor.fromJson(Map<String, dynamic> json) {
    return OrderPagingInfor(
      hasNextPage: json['hasNextPage'],
      currentPage: json['currentPage'],
    );
  }
}

class OrderList extends ChangeNotifier {
  Map<String, Order> _list;
  OrderPagingInfor pageInfo;
  final String conversationId;

  OrderList({this.conversationId});

  UnmodifiableMapView get map => UnmodifiableMapView(_list);
  List<Order> get list => _list.values.toList();

  void _addList(List<Order> orders) {
    orders.forEach((order) {
      if (!_list.containsKey(order.id)) {
        _list[order.id] = order;
      }
    });
    notifyListeners();
  }

  Future<OrderList> fetchData() async {
    if (_list == null) {
      _list = new Map<String, Order>();
      final data = this.conversationId != null
          ? await OrderAPI.fetchOrdersOfConversation(
              conversationId: this.conversationId)
          : await OrderAPI.fetchOrders();
      _addList(data.item1);
      pageInfo = data.item2;
    }
    return this;
  }

  Future<bool> refreshData() async {
    final data = this.conversationId != null
        ? await OrderAPI.fetchOrdersOfConversation(
            conversationId: this.conversationId)
        : await OrderAPI.fetchOrders();
    if (data != null) {
      _list.clear();
      _addList(data.item1);
      this.pageInfo = data.item2;
      return true;
    }
    return false;
  }

  Future<bool> loadMoreData() async {
    if (pageInfo.hasNextPage) {
      final count = _list.length;
      final data = this.conversationId != null
          ? await OrderAPI.fetchOrdersOfConversation(
              conversationId: this.conversationId,
              page: pageInfo.currentPage + 1,
            )
          : await OrderAPI.fetchOrders(
              page: pageInfo.currentPage + 1,
            );
      if (data != null) {
        _addList(data.item1);
        this.pageInfo = data.item2;
        return count < _list.length ? true : false;
      }
    }
    return false;
  }
}
