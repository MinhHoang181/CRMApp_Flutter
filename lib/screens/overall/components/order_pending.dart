import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
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
          margin: EdgeInsets.only(
            top: Layouts.SPACING,
            left: Layouts.SPACING,
            right: Layouts.SPACING,
          ),
          padding: EdgeInsets.symmetric(horizontal: Layouts.SPACING),
          child: Text(
            'Đơn hàng chờ xử lý',
            style: Theme.of(context).textTheme.subtitle1,
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
              Row(
                children: [
                  SizedBox(
                    width: 27,
                    height: 27,
                    child: Image(
                      image: AssetImage(MyIcons.APPROVE),
                    ),
                  ),
                  SizedBox(width: Layouts.SPACING),
                  Text(
                    'Chờ duyệt',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Spacer(),
                  Text(
                    '$_orderCheck',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(width: Layouts.SPACING),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).accentColor,
                  ),
                ],
              ),
              SizedBox(height: Layouts.SPACING/2),
              Divider(thickness: 0.5, indent: 0.5,),
              SizedBox(height: Layouts.SPACING/2),
              Row(
                children: [
                  SizedBox(
                    width: 27,
                    height: 27,
                    child: Image(
                      image: AssetImage(MyIcons.MONEY),
                    ),
                  ),
                  SizedBox(width: Layouts.SPACING),
                  Text(
                    'Chờ thanh toán',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Spacer(),
                  Text(
                    '$_orderPayment',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(width: Layouts.SPACING),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).accentColor,
                  ),
                ],
              ),
              SizedBox(height: Layouts.SPACING/2),
              Divider(thickness: 0.5, indent: 0.5,),
              SizedBox(height: Layouts.SPACING/2),
              Row(
                children: [
                  SizedBox(
                    width: 27,
                    height: 27,
                    child: Image(
                      image: AssetImage(MyIcons.BOX),
                    ),
                  ),
                  SizedBox(width: Layouts.SPACING),
                  Text(
                    'Chờ đóng gói',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Spacer(),
                  Text(
                    '$_orderPack',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(width: Layouts.SPACING),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).accentColor,
                  ),
                ],
              ),
              SizedBox(height: Layouts.SPACING/2),
              Divider(thickness: 0.5, indent: 0.5,),
              SizedBox(height: Layouts.SPACING/2),
              Row(
                children: [
                  SizedBox(
                    width: 27,
                    height: 27,
                    child: Image(
                      image: AssetImage(MyIcons.DELIVERY),
                    ),
                  ),
                  SizedBox(width: Layouts.SPACING),
                  Text(
                    'Chờ vận chuyển',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Spacer(),
                  Text(
                    '$_orderDelivery',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(width: Layouts.SPACING),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).accentColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
