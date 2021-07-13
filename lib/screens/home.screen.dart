import 'dart:math';
import 'package:badges/badges.dart';
import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/list_model/ConversationList.dart';

import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:provider/provider.dart';

//Screens
import 'overall/overall.screen.dart';
import 'orders/orders.screen.dart';
import 'customers/customers.screen.dart';
import 'messenger/messenger.screen.dart';
import 'more/more.screen.dart';

//Models
import 'package:cntt2_crm/models/Conversation/Conversations.dart';

class Home extends StatefulWidget {
  final List<Widget> _bodyOption = <Widget>[
    OverallScreen(),
    OrdersScreen(),
    CustomersScreen(),
    MessengerScreen(),
    MoreScreen(),
  ];
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget._bodyOption.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: 'Đơn hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_rounded),
            label: 'Khách hàng',
          ),
          BottomNavigationBarItem(
            icon: ChangeNotifierProvider<Conversations>.value(
              value: AzsalesData
                  .instance.conversations.map[PlatformConversation.all],
              child: _MessageItem(),
            ),
            label: 'Tin nhắn',
          ),
          BottomNavigationBarItem(
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

class _MessageItem extends StatelessWidget {
  const _MessageItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conversations = context.watch<Conversations>();
    final messNotification = min(conversations.unreadCount, 999);
    return Badge(
      padding: EdgeInsets.all(Layouts.SPACING / 3),
      position: BadgePosition.topEnd(
        top: -Layouts.SPACING,
        end: -Layouts.SPACING,
      ),
      child: Icon(Icons.messenger_rounded),
      badgeContent: Text(
        '$messNotification',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      showBadge: messNotification > 0 ? true : false,
    );
  }
}
