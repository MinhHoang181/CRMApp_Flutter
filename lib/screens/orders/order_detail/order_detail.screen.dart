import 'package:flutter/material.dart';

class OrderDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _ordersDetailScreenAppBar(context),
      body: Center(
        child: Text('order detail'),
      ),
    );
  }

  AppBar _ordersDetailScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Thông tin đơn hàng'),
    );
  }
}
