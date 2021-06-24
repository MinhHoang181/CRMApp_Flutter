import 'dart:collection';

import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/Product/Variant.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/product_api.dart';
import 'package:flutter/material.dart';

class VariantList {
  final String productId;
  Map<int, Variant> _list;

  VariantList({@required this.productId});
  UnmodifiableMapView get map => UnmodifiableMapView(_list);

  void _addList(List<Variant> variants) {
    variants.forEach((variant) {
      if (!_list.containsKey(variant.id)) {
        _list[variant.id] = variant;
      }
    });
  }

  Future<VariantList> fetchData({List<Variant> list}) async {
    if (_list == null) {
      if (list != null) {
        _list = new Map<int, Variant>();
        _addList(list);
      } else {
        _list = new Map<int, Variant>();
        final variants = await ProductAPI.fetchVariantOfProduct(
          product: AzsalesData.instance.products.map[this.productId],
        );
        if (variants != null) {
          _addList(variants);
        }
      }
    }
    return this;
  }
}
