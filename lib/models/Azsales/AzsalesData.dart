import 'package:cntt2_crm/models/Order/DailyOrderInfo.dart';
import 'package:cntt2_crm/models/Order/PendedOrderInfo.dart';
import 'package:cntt2_crm/models/list_model/ConversationList.dart';
import 'package:cntt2_crm/models/Azsales/AzsalesAccount.dart';
import 'package:cntt2_crm/models/list_model/FacebookPageList.dart';
import 'package:cntt2_crm/models/list_model/LabelList.dart';
import 'package:cntt2_crm/models/list_model/Location.dart';
import 'package:cntt2_crm/models/list_model/OrderList.dart';
import 'package:cntt2_crm/models/list_model/ProductList.dart';
import 'package:cntt2_crm/models/list_model/ReplyList.dart';
import 'package:cntt2_crm/models/list_model/ShipperList.dart';
import 'package:cntt2_crm/models/list_model/StockList.dart';
import 'package:cntt2_crm/theme.dart';
import 'package:flutter/material.dart';

class AzsalesData extends ChangeNotifier {
  static AzsalesData _instance = AzsalesData._();

  String azsalesAccessToken;
  AzsalesAccount azsalesAccount = AzsalesAccount();

  final LabelList labels = LabelList();
  final ReplyList replies = ReplyList();
  final FacebookPageList pages = FacebookPageList();
  final Location location = Location();
  final ProductList products = ProductList();
  final StockList stocks = StockList();
  final OrderList orders = OrderList();
  final ShipperList shippers = ShipperList();
  final DailyOrderInfo dailyOrderInfo = DailyOrderInfo();
  final PendedOrderInfo pendedOrderInfo = PendedOrderInfo();

  bool _ligthTheme = true;
  bool get ligthTheme => _ligthTheme;

  void toggleTheme() {
    _ligthTheme = !_ligthTheme;
    notifyListeners();
  }

  ThemeData theme(BuildContext context) {
    return ligthTheme ? ligthThemeData(context) : darkThemeData(context);
  }

  //Chat - Conversation
  final ConversationList conversations = ConversationList();

  static AzsalesData get instance => _instance;

  //SINGLETON
  AzsalesData._();

  Future<AzsalesData> fetchData() async {
    await Future.wait([
      pages.fetchData(),
      labels.fetchData(),
      replies.fetchData(),
      conversations.fetchData(),
      location.fetchData(),
      stocks.fetchData(),
      dailyOrderInfo.fetchData(),
    ]);
    return this;
  }

  //AZSALESACCOUNT
  void updateAzsalesAccount(AzsalesAccount account) {
    azsalesAccount = account;
    notifyListeners();
  }
}
