import 'package:flutter/material.dart';

//Components
import 'components/body.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _ordersScreenAppBar(context),
      body: Body(),
    );
  }

  AppBar _ordersScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Quản lý đơn hàng'),
    );
  }
}
