import 'dart:collection';

import 'package:cntt2_crm/models/Shipper.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/shipping_api.dart';
import 'package:flutter/material.dart';

class ShipperList extends ChangeNotifier {
  Map<String, Shipper> _list;
  UnmodifiableMapView get map => UnmodifiableMapView(_list);

  void _addList(List<Shipper> shippers) {
    shippers.forEach((shipper) {
      if (!_list.containsKey(shipper.id)) {
        _list[shipper.id] = shipper;
      }
    });
    notifyListeners();
  }

  Future<ShipperList> fetchData() async {
    if (_list == null) {
      _list = Map<String, Shipper>();
      final shippers = await ShippingAPI.fetchAllShipper();
      if (shippers != null) {
        _addList(shippers);
      }
    }
    return this;
  }

  Future<bool> refreshData() async {
    final shippers = await ShippingAPI.fetchAllShipper();
    if (shippers != null) {
      _list.clear();
      _addList(shippers);
      return true;
    }
    return false;
  }
}
