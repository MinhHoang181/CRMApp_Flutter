import 'dart:collection';

import 'package:cntt2_crm/models/Stock.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/stock_api.dart';

class StockList {
  Map<String, Stock> _list;

  UnmodifiableMapView get map => UnmodifiableMapView(_list);

  void _addList(List<Stock> stocks) {
    stocks.forEach((stock) {
      if (!_list.containsKey(stock.id)) {
        _list[stock.id] = stock;
      }
    });
  }

  Future<StockList> fetchData() async {
    if (_list == null) {
      _list = new Map<String, Stock>();
      final stocks = await StockAPI.fetchAllStock();
      if (stocks != null) {
        _addList(stocks);
      }
    }
    return this;
  }
}
