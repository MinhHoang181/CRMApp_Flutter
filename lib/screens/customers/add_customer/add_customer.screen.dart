import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Screens
import 'components/body.dart';

class AddCustomerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _addCustomerScreenAppBar(context),
      body: Body(),
      bottomNavigationBar: _saveButton(context),
    );
  }

  AppBar _addCustomerScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Thêm khách hàng'),
    );
  }

  BottomAppBar _saveButton(BuildContext context) {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Layouts.SPACING),
        child: ElevatedButton(
          child: Text('Lưu'),
          onPressed: () => {},
        ),
      ),
    );
  }
}
