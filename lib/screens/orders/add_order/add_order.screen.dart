import 'package:flutter/material.dart';

class AddOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _addOrderScreenAppBar(context),
    );
  }

  AppBar _addOrderScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Thêm đơn hàng'),
    );
  }
}
