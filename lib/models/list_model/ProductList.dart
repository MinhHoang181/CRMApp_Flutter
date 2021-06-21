import 'dart:collection';

import 'package:cntt2_crm/models/PageInfo.dart';
import 'package:cntt2_crm/models/Product/Product.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/product_api.dart';
import 'package:flutter/material.dart';

class ProductList extends ChangeNotifier {
  PageInfo pageInfo;
  Map<String, Product> _list;
  UnmodifiableMapView get map => UnmodifiableMapView(_list);

  void _addList(List<Product> products) {
    products.forEach((product) {
      if (!_list.containsKey(product.id)) {
        _list[product.id] = product;
      }
    });
    notifyListeners();
  }

  Future<ProductList> fetchData() async {
    if (_list == null) {
      _list = new Map<String, Product>();
      final data = await ProductAPI.fetchAllProduct();
      if (data != null) {
        _addList(data.item1);
        pageInfo = data.item2;
      }
    }
    return this;
  }

  Future<bool> refreshData() async {
    final data = await ProductAPI.fetchAllProduct();
    if (data != null) {
      _list.clear();
      _addList(data.item1);
      pageInfo = data.item2;
      return true;
    }
    return false;
  }

  Future<bool> loadMoreData() async {
    if (pageInfo.hasNextPage) {
      final count = _list.length;
      final data =
          await ProductAPI.fetchAllProduct(page: pageInfo.currentPage + 1);
      if (data != null) {
        _addList(data.item1);
        pageInfo = data.item2;
        return count < _list.length ? true : false;
      }
    }
    return false;
  }
}
