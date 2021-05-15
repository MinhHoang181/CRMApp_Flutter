import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ordersScreenAppBar(context),
      body: Center(
        child: Text("Orders"),
      ),
    );
  }

  static AppBar ordersScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Orders'),
    );
  }
}