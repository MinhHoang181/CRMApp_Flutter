import 'dart:collection';

import 'package:cntt2_crm/models/Order/FilterOrder.dart';
import 'package:cntt2_crm/models/Order/Order.dart';
import 'package:cntt2_crm/models/PageInfo.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/order_api.dart';
import 'package:flutter/material.dart';

class OrderList extends ChangeNotifier {
  final String conversationId;
  OrderList({this.conversationId});

  Map<FilterOrder, Map<String, Order>> _list = Map.fromIterable(
    FilterOrder.values,
    key: (element) => element,
    value: (e) => null,
  );

  UnmodifiableMapView get map => UnmodifiableMapView(_list[FilterOrder.all]);
  UnmodifiableMapView filter(FilterOrder filterOrder) =>
      UnmodifiableMapView(_list[filterOrder]);

  Map<FilterOrder, PageInfo> _pageInfo = <FilterOrder, PageInfo>{
    FilterOrder.all: PageInfo(hasNextPage: false, currentPage: 1),
    FilterOrder.status_new: null,
  };
  PageInfo get pageInfo => _pageInfo[FilterOrder.all];
  set pageInfo(PageInfo info) {
    _pageInfo[FilterOrder.all] = info;
  }

  void _addList(FilterOrder filterOrder, List<Order> orders) {
    orders.forEach((order) {
      if (!_list[filterOrder].containsKey(order.id)) {
        _list[filterOrder][order.id] = order;
      }
    });
    notifyListeners();
  }

  Future<OrderList> fetchData() async {
    if (_list[FilterOrder.all] == null) {
      _list[FilterOrder.all] = Map<String, Order>();
      final data = this.conversationId != null
          ? await OrderAPI.fetchOrdersOfConversation(
              conversationId: this.conversationId)
          : await OrderAPI.fetchOrders();
      if (data != null) {
        _addList(FilterOrder.all, data.item1);
        pageInfo = data.item2;
      }
    }
    return this;
  }

  Future<OrderList> fetchDataWithFilter(FilterOrder filterOrder) async {
    if (_list[filterOrder] == null) {
      _list[filterOrder] = Map<String, Order>();
      final data = await OrderAPI.fetchOrders(filterOrder: filterOrder);
      if (data != null) {
        _addList(filterOrder, data.item1);
        _pageInfo[filterOrder] = data.item2;
      }
    }
    return this;
  }

  Future<bool> refreshData() async {
    final data = this.conversationId != null
        ? await OrderAPI.fetchOrdersOfConversation(
            conversationId: this.conversationId)
        : await OrderAPI.fetchOrders();
    if (data != null) {
      _list[FilterOrder.all].clear();
      _addList(FilterOrder.all, data.item1);
      pageInfo = data.item2;
      return true;
    }
    return false;
  }

  Future<bool> refreshDataWithFilter(FilterOrder filterOrder) async {
    final data = await OrderAPI.fetchOrders(filterOrder: filterOrder);
    if (data != null) {
      _list[filterOrder].clear();
      _addList(filterOrder, data.item1);
      _pageInfo[filterOrder] = data.item2;
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
        _addList(FilterOrder.all, data.item1);
        pageInfo = data.item2;
        return count < _list.length ? true : false;
      }
    }
    return false;
  }

  Future<bool> loadMoreDataWithFilter(FilterOrder filterOrder) async {
    if (_pageInfo[filterOrder].hasNextPage) {
      final count = _list[filterOrder].length;
      final data = await OrderAPI.fetchOrders(
        page: _pageInfo[filterOrder].currentPage + 1,
        filterOrder: filterOrder,
      );
      if (data != null) {
        _addList(filterOrder, data.item1);
        _pageInfo[filterOrder] = data.item2;
        return count < _list[filterOrder].length ? true : false;
      }
    }
    return false;
  }
}
