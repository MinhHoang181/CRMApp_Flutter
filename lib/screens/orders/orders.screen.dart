import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _ordersScreenAppBar(context),
      body: Center(
        child: Text("Orders"),
      ),
    );
  }

  AppBar _ordersScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Orders'),
    );
  }
}
