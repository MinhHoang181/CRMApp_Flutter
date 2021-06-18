import 'dart:collection';

import 'package:cntt2_crm/models/Customer.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/customer_api.dart';
import 'package:flutter/material.dart';

class CustomerPagingInfor {
  bool hasNextPage = false;
  int currentPage = 1;

  CustomerPagingInfor({
    @required this.hasNextPage,
    @required this.currentPage,
  });

  factory CustomerPagingInfor.fromJson(Map<String, dynamic> json) {
    return CustomerPagingInfor(
      hasNextPage: json['hasNextPage'],
      currentPage: json['currentPage'],
    );
  }
}

class CustomerList extends ChangeNotifier {
  Map<String, dynamic> _list;
  final String conversationId;
  CustomerPagingInfor pageInfo;

  CustomerList({this.conversationId});

  UnmodifiableMapView get map => UnmodifiableMapView(_list);
  List<Customer> get list => _list.values.toList();

  void _addList(List<Customer> customers) {
    customers.forEach((customer) {
      if (!_list.containsKey(customer.id)) {
        _list[customer.id] = customer;
      }
    });
    notifyListeners();
  }

  Future<CustomerList> fetchData() async {
    if (_list == null) {
      _list = new Map<String, Customer>();
      if (conversationId != null) {
        final customers = await CustomerAPI.fetchAllCustomersOfConversation(
            conversationId: this.conversationId);
        _addList(customers);
      }
    }
    return this;
  }

  Future<bool> refreshData() async {
    if (conversationId != null) {
      final customers = await CustomerAPI.fetchAllCustomersOfConversation(
          conversationId: this.conversationId);
      if (customers != null) {
        _list.clear();
        _addList(customers);
        return true;
      }
    }
    return false;
  }
}
