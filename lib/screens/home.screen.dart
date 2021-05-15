import 'package:flutter/material.dart';
import 'overall/overall.screen.dart';
import 'orders/orders.screen.dart';
import 'products/products.screen.dart';
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
    ProductsScreen(),
    MessengerScreen(),
    MoreScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyOption.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Trang chu',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: 'Hoa don',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket_rounded),
            label: 'San pham',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.messenger_rounded),
            label: 'Tin nhan',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.menu_rounded),
            label: 'Them',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

