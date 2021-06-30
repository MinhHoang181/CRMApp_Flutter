import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/Order/PendedOrderInfo.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/icons.dart' as MyIcons;

class OrdersPending extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PendedOrderInfo>(
      future: AzsalesData.instance.pendedOrderInfo.fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _orderPending(context, snapshot.data);
        } else if (snapshot.hasError) {
          print(snapshot.error.toString());
        }
        return _orderPending(context, null);
      },
    );
  }

  Widget _orderPending(BuildContext context, PendedOrderInfo pendedOrderInfo) {
    final waitConfirm =
        pendedOrderInfo != null ? pendedOrderInfo.waitConfirm : null;
    final waitShipping =
        pendedOrderInfo != null ? pendedOrderInfo.waitShipping : null;
    final waitPay = pendedOrderInfo != null ? pendedOrderInfo.waitPay : null;
    final waitReturn =
        pendedOrderInfo != null ? pendedOrderInfo.waitReturn : null;
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
              _orderWaitCheck(context, waitConfirm),
              Divider(),
              _orderWaitTranport(context, waitShipping),
              Divider(),
              _orderWaitPayment(context, waitPay),
              Divider(),
              _orderWaitReturn(context, waitReturn),
            ],
          ),
        ),
      ],
    );
  }

  Widget _orderWaitCheck(BuildContext context, int waitConfirm) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: Image(
            image: AssetImage(MyIcons.APPROVE),
          ),
        ),
        SizedBox(width: Layouts.SPACING),
        Text(
          'Chờ duyệt',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Spacer(),
        Text(
          waitConfirm != null ? '$waitConfirm' : 'Đang cập nhật',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }

  Widget _orderWaitTranport(BuildContext context, int waitShipping) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: Image(
            image: AssetImage(MyIcons.DELIVERY),
          ),
        ),
        SizedBox(width: Layouts.SPACING),
        Text(
          'Chờ vận chuyển',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Spacer(),
        Text(
          waitShipping != null ? '$waitShipping' : 'Đang cập nhật',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }

  Widget _orderWaitPayment(BuildContext context, int waitPay) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: Image(
            image: AssetImage(MyIcons.MONEY),
          ),
        ),
        SizedBox(width: Layouts.SPACING),
        Text(
          'Chờ thanh toán',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Spacer(),
        Text(
          waitPay != null ? '$waitPay' : 'Đang cập nhật',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }

  Widget _orderWaitReturn(BuildContext context, int waitReturn) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: Image(
            image: AssetImage(MyIcons.BOX),
          ),
        ),
        SizedBox(width: Layouts.SPACING),
        Text(
          'Chờ trả hàng',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Spacer(),
        Text(
          waitReturn != null ? '$waitReturn' : 'Đang cập nhật',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
