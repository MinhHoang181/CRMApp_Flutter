import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;

//Screens
import 'add_order/add_order.screen.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _ordersScreenAppBar(context),
      body: _Body(),
    );
  }

  AppBar _ordersScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Quản lý đơn hàng'),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              _createOrderButton(context),
              _OrdersManager(),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _createOrderButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Layouts.SPACING * 2,
        vertical: Layouts.SPACING,
      ),
      padding: EdgeInsets.all(Layouts.SPACING),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Theme.of(context).shadowColor,
          ),
        ],
      ),
      child: InkWell(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Icon(
                Icons.add_shopping_cart_rounded,
                color: Colors.white,
                size: 60,
              ),
              SizedBox(height: Layouts.SPACING / 2),
              Text(
                'Tạo đơn hàng mới',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: Fonts.SIZE_TEXT_LARGE),
              ),
            ],
          ),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddOrderScreen(),
          ),
        ),
      ),
    );
  }
}

class _OrdersManager extends StatefulWidget {
  @override
  _OrdersManagerState createState() => _OrdersManagerState();
}

class _OrdersManagerState extends State<_OrdersManager> {
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
