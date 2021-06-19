import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/icons.dart' as MyIcons;
//Screens
import '../list_order/list_order.screen.dart';

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
            leading: SizedBox(
              width: 30,
              height: 30,
              child: Image(
                image: AssetImage(MyIcons.ALL_BILLS),
              ),
            ),
            title: Row(
              children: [
                Text('Danh sách đơn hàng', style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w500),),
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
            trailing: Icon(Icons.arrow_forward_ios,color: Theme.of(context).accentColor,),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListOrderScreen(),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading:  SizedBox(
              width: 32,
              height: 32,
              child: Image(
                image: AssetImage(MyIcons.REFUND_BOX),
              ),
            ),
            title: Row(
              children: [
                Text('Khách trả hàng',style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w500)),
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
            trailing: Icon(Icons.arrow_forward_ios,color: Theme.of(context).accentColor,),
          ),
          Divider(),
          ListTile(
            leading:  SizedBox(
              width: 30,
              height: 30,
              child: Image(
                image: AssetImage(MyIcons.CAR_DELIVERY),
              ),
            ),
            title: Row(
              children: [
                Text('Quản lý giao hàng',style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w500)),
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
            trailing: Icon(Icons.arrow_forward_ios,color: Theme.of(context).accentColor,),
          ),
        ],
      ),
    );
  }
}
