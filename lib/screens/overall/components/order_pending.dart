import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/icons.dart' as MyIcons;

class OrdersPending extends StatelessWidget {
  final int _orderCheck = 10;
  final int _orderPayment = 1;
  final int _orderReturn = 4;
  final int _orderDelivery = 1;
  @override
  Widget build(BuildContext context) {
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
              _orderWaitCheck(context),
              Divider(),
              _orderWaitTranport(context),
              Divider(),
              _orderWaitPayment(context),
              Divider(),
              _orderWaitReturn(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _orderWaitCheck(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 45,
          height: 45,
          child: Image(
            image: AssetImage(MyIcons.APPROVE2),
          ),
        ),
        SizedBox(width: Layouts.SPACING),
        Text(
          'Chờ duyệt',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Spacer(),
        Text(
          '$_orderCheck',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(width: Layouts.SPACING),
        Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).accentColor,
        ),
      ],
    );
  }

  Widget _orderWaitTranport(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 48,
          height: 48,
          child: Image(
            image: AssetImage(MyIcons.DELIVERY2),
          ),
        ),
        SizedBox(width: Layouts.SPACING),
        Text(
          'Chờ vận chuyển',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Spacer(),
        Text(
          '$_orderDelivery',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(width: Layouts.SPACING),
        Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).accentColor,
        ),
      ],
    );
  }

  Widget _orderWaitPayment(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 42,
          height: 42,
          child: Image(
            image: AssetImage(MyIcons.MONEY_BAG),
          ),
        ),
        SizedBox(width: Layouts.SPACING),
        Text(
          'Chờ thanh toán',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Spacer(),
        Text(
          '$_orderPayment',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(width: Layouts.SPACING),
        Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).accentColor,
        ),
      ],
    );
  }

  Widget _orderWaitReturn(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 45,
          height: 45,
          child: Image(
            image: AssetImage(MyIcons.BOX2),
          ),
        ),
        SizedBox(width: Layouts.SPACING),
        Text(
          'Chờ trả hàng',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Spacer(),
        Text(
          '$_orderReturn',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(width: Layouts.SPACING),
        Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).accentColor,
        ),
      ],
    );
  }
}
