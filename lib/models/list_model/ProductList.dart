import 'dart:collection';

import 'package:cntt2_crm/models/PageInfo.dart';
import 'package:cntt2_crm/models/Product/Product.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/product_api.dart';
import 'package:flutter/material.dart';

class ProductList extends ChangeNotifier {
  static List<String> filter = [
    'Tất cả',
    'Còn hàng',
  ];
  int _filterId = 0;
  int get filterId => _filterId;
  set filterId(int value) {
    _filterId = value;
    notifyListeners();
  }

  PageInfo pageInfo;
  Map<String, Product> _list;

  UnmodifiableMapView get map {
    switch (_filterId) {
      case 1:
        final filter = Map.fromIterable(
          _list.values.where((product) => product.total > 0),
        );
        return UnmodifiableMapView(filter);
      default:
        return UnmodifiableMapView(_list);
    }
  }

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
      final data = await ProductAPI.fetchProductPaging();
      if (data != null) {
        _addList(data.item1);
        pageInfo = data.item2;
      }
    }
    return this;
  }

  Future<bool> searchProduct(String text) async {
    final products = await ProductAPI.fetchProducts(text: text);
    if (products != null) {
      pageInfo.currentPage = 1;
      pageInfo.hasNextPage = false;
      _list.clear();
      _addList(products);
      return true;
    }
    return false;
  }

  Future<bool> refreshData() async {
    final data = await ProductAPI.fetchProductPaging();
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
          await ProductAPI.fetchProductPaging(page: pageInfo.currentPage + 1);
      if (data != null) {
        _addList(data.item1);
        pageInfo = data.item2;
        return count < _list.length ? true : false;
      }
    }
    return false;
  }
}
