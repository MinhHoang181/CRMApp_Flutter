import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

class PaymentMethod extends StatefulWidget {
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Layouts.SPACING / 2),
      padding: EdgeInsets.symmetric(
        vertical: Layouts.SPACING / 2,
        horizontal: Layouts.SPACING,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(Icons.attach_money_rounded,color: Theme.of(context).accentColor,),
        title: Text('Chọn phương thức thanh toán'),
        trailing: Icon(Icons.arrow_forward_ios,color: Theme.of(context).accentColor,),
      ),
    );
  }
}
