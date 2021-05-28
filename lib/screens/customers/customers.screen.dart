import 'package:flutter/material.dart';

//Screens
import 'no_customer.screen.dart';

class CustomersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _customerScreenAppBar(context),
      body: NoCustomerScreen(),
    );
  }

  AppBar _customerScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Quản lý khách hàng'),
    );
  }
}
