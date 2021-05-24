import 'dart:math';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

import 'overall/overall.screen.dart';
import 'orders/orders.screen.dart';
import 'customers/customers.screen.dart';
import 'messenger/messenger.screen.dart';
import 'more/more.screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static List<Widget> _bodyOption = <Widget>[
    OverallScreen(),
    OrdersScreen(),
    CustomersScreen(),
    MessengerScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var _messNotfiCount = min(10, 999);
    return Scaffold(
      body: _bodyOption.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Trang chủ',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: 'Đơn hàng',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_rounded),
            label: 'Khách hàng',
          ),
          new BottomNavigationBarItem(
            icon: Badge(
              padding: EdgeInsets.all(Layouts.SPACING / 3),
              position: BadgePosition.topEnd(
                top: -Layouts.SPACING,
                end: -Layouts.SPACING,
              ),
              child: Icon(Icons.messenger_rounded),
              badgeContent: Text(
                '$_messNotfiCount',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              showBadge: _messNotfiCount > 0 ? true : false,
            ),
            label: 'Tin nhắn',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.apps_rounded),
            label: 'Thêm',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: Fonts.SIZE_ICON_LABEL,
        unselectedFontSize: Fonts.SIZE_ICON_LABEL,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
