import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

class OrdersManager extends StatefulWidget {
  @override
  _OrdersManagerState createState() => _OrdersManagerState();
}

class _OrdersManagerState extends State<OrdersManager> {
  int _newOrder;
  int _newReturnOrder;
  int _newDeliveryOrder;
  @override
  Widget build(BuildContext context) {
    _newOrder = 10;
    _newDeliveryOrder = 5;
    _newReturnOrder = 2;

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
            leading: Icon(Icons.list_rounded),
            title: Row(
              children: [
                Text('Danh sách đơn hàng'),
                SizedBox(width: Layouts.SPACING),
                Badge(
                  padding: EdgeInsets.all(Layouts.SPACING / 3),
                  badgeContent: Text(
                    '$_newOrder',
                    style: TextStyle(color: Colors.white),
                  ),
                  showBadge: _newOrder > 0 ? true : false,
                ),
              ],
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.remove_shopping_cart_rounded),
            title: Row(
              children: [
                Text('Khách trả hàng'),
                SizedBox(width: Layouts.SPACING),
                Badge(
                  padding: EdgeInsets.all(Layouts.SPACING / 3),
                  badgeContent: Text(
                    '$_newReturnOrder',
                    style: TextStyle(color: Colors.white),
                  ),
                  showBadge: _newReturnOrder > 0 ? true : false,
                ),
              ],
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.drive_eta_rounded),
            title: Row(
              children: [
                Text('Quản lý giao hàng'),
                SizedBox(width: Layouts.SPACING),
                Badge(
                  padding: EdgeInsets.all(Layouts.SPACING / 3),
                  badgeContent: Text(
                    '$_newDeliveryOrder',
                    style: TextStyle(color: Colors.white),
                  ),
                  showBadge: _newDeliveryOrder > 0 ? true : false,
                ),
              ],
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
