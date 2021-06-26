import 'package:flutter/material.dart';

//Componetns
import 'components/body.dart';

class ShippingManagerScreen extends StatelessWidget {
  const ShippingManagerScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _shippingManagerScreenAppBar(context),
      body: Body(),
    );
  }

  AppBar _shippingManagerScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Quản lý đối tác vận chuyển'),
    );
  }
}
