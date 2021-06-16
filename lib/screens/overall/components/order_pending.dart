import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;
import 'package:cntt2_crm/constants/icons.dart' as MyIcons;

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
                blurRadius: 3,
                offset: Offset(0, 3),
                color: Theme.of(context).shadowColor,
              ),
            ],
          ),
          child: Column(
            children: [
              ListTile(
                leading: SizedBox(
                  width: 35,
                  height: 35,
                  child: Image(
                    image: AssetImage(MyIcons.APPROVE),
                  ),
                ),
                title: Row(
                  children: [
                    Text('Chờ duyệt',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('$_orderCheck',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).accentColor,),
              ),
              Divider(),
              ListTile(
                leading: SizedBox(
                  width: 35,
                  height: 35,
                  child: Image(
                    image: AssetImage(MyIcons.MONEY),
                  ),
                ),
                title: Row(
                  children: [
                    Text('Chờ thanh toán',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('$_orderPayment',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).accentColor,),
              ),
              Divider(),
              ListTile(
                leading: SizedBox(
                  width: 35,
                  height: 35,
                  child: Image(
                    image: AssetImage(MyIcons.BOX),
                  ),
                ),
                title: Row(
                  children: [
                    Text('Chờ đóng gói',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('$_orderPack',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).accentColor),
              ),
              Divider(),
              ListTile(
                leading: SizedBox(
                  width: 35,
                  height: 35,
                  child: Image(
                    image: AssetImage(MyIcons.DELIVERY),
                  ),
                ),
                title: Row(
                  children: [
                    Text('Chờ vận chuyển',
                      style: TextStyle(
                      fontWeight: FontWeight.normal,
                      ),
                    ),
                    Spacer(),
                    Align(
                      child: Text('$_orderDelivery',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ],
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).accentColor,),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
