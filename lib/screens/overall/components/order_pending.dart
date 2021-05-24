import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;

class OrdersPending extends StatefulWidget {
  @override
  _OrdersPendingState createState() => _OrdersPendingState();
}

class _OrdersPendingState extends State<OrdersPending> {
  int _orderCheck;
  int _orderPayment;
  int _orderPack;
  int _orderDelivery;
  @override
  Widget build(BuildContext context) {
    _orderCheck = 10;
    _orderPayment = 2;
    _orderPack = 4;
    _orderDelivery = 15;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: Layouts.SPACING),
          padding: EdgeInsets.symmetric(horizontal: Layouts.SPACING),
          child: Text(
            'Đơn hàng chờ xử lý',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Fonts.SIZE_TEXT_LARGE,
            ),
          ),
        ),
        SizedBox(
          height: Layouts.SPACING,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: Layouts.SPACING),
          padding: EdgeInsets.all(Layouts.SPACING),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Theme.of(context).shadowColor,
              ),
            ],
          ),
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.assignment_turned_in_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                title: Row(
                  children: [
                    Text('Chờ duyệt'),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('$_orderCheck'),
                    ),
                  ],
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.payments_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                title: Row(
                  children: [
                    Text('Chờ thanh toán'),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('$_orderPayment'),
                    ),
                  ],
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.shopping_basket_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                title: Row(
                  children: [
                    Text('Chờ đóng gói'),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('$_orderPack'),
                    ),
                  ],
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.directions_car_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                title: Row(
                  children: [
                    Text('Chờ vận chuyển'),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('$_orderDelivery'),
                    ),
                  ],
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
