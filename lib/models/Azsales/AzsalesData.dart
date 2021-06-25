import 'package:cntt2_crm/models/list_model/ConversationList.dart';
import 'package:cntt2_crm/models/Azsales/AzsalesAccount.dart';
import 'package:cntt2_crm/models/list_model/FacebookPageList.dart';
import 'package:cntt2_crm/models/list_model/LabelList.dart';
import 'package:cntt2_crm/models/list_model/Location.dart';
import 'package:cntt2_crm/models/list_model/ProductList.dart';
import 'package:cntt2_crm/models/list_model/ReplyList.dart';
import 'package:cntt2_crm/models/list_model/StockList.dart';
import 'package:cntt2_crm/theme.dart';
import 'package:flutter/material.dart';

class AzsalesData extends ChangeNotifier {
  static AzsalesData _instance = AzsalesData._();

  String azsalesAccessToken;
  AzsalesAccount azsalesAccount = new AzsalesAccount();

  final LabelList labels = new LabelList();
  final ReplyList replies = new ReplyList();
  final FacebookPageList pages = new FacebookPageList();
  final Location location = new Location();
  final ProductList products = new ProductList();
  final StockList stocks = new StockList();

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
  final ConversationList conversations = new ConversationList();

  static AzsalesData get instance => _instance;

  //SINGLETON
  AzsalesData._();

  Future<AzsalesData> fetchData() async {
    //pages
    await pages.fetchData();
    //labels
    await labels.fetchData();
    //QuickReplies
    await replies.fetchData();
    //Conversations
    await conversations.fetchData();
    //Location
    await location.fetchData();
    //Stock
    await stocks.fetchData();
    return this;
  }

  //AZSALESACCOUNT
  void updateAzsalesAccount(AzsalesAccount account) {
    azsalesAccount = account;
    notifyListeners();
  }
}
