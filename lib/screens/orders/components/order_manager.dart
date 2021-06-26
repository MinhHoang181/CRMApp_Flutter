import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/icons.dart' as MyIcons;

//Screens
import '../list_order/list_order.screen.dart';
import '../list_order/return_order.screen.dart';
import '../shipping_manager/shipping_manager.screen.dart';

class OrdersManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: Layouts.SPACING,
      ),
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 2,
          ),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            leading: SizedBox(
              width: 30,
              height: 30,
              child: Image(
                image: AssetImage(MyIcons.ALL_BILLS),
              ),
            ),
            title: Text(
              'Danh sách đơn hàng',
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).accentColor,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListOrderScreen(),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: SizedBox(
              width: 32,
              height: 32,
              child: Image(
                image: AssetImage(MyIcons.REFUND_BOX),
              ),
            ),
            title: Text(
              'Khách trả hàng',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).accentColor,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReturnOrderScreen(),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: SizedBox(
              width: 30,
              height: 30,
              child: Image(
                image: AssetImage(MyIcons.CAR_DELIVERY),
              ),
            ),
            title: Text(
              'Quản lý giao hàng',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).accentColor,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShippingManagerScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
