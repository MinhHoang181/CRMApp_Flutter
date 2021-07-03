import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/images.dart' as Images;
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';

//Screen
import 'list_messenger/facebook/facebook_message.screen.dart';
import 'list_messenger/all/all_message.screen.dart';

//Models
import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/Conversation/Conversations.dart';
import 'package:cntt2_crm/models/list_model/ConversationList.dart';

class MessengerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _messengerScreenAppBar(context),
      body: _listPlatform(context),
    );
  }

  AppBar _messengerScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Quản lý tin nhắn'),
    );
  }

  Widget _listPlatform(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Layouts.SPACING),
      child: Column(
        children: [
          _all(context),
          Divider(),
          _facebook(context),
          Divider(),
          _zalo(context),
        ],
      ),
    );
  }

  Widget _all(BuildContext context) {
    int notificationCount = 1;
    notificationCount = min(notificationCount, 999);
    return ListTile(
      leading: Image(
        height: 60,
        width: 60,
        image: AssetImage(Images.AZSALES),
      ),
      title: Text('Tất cả'),
      subtitle: Text(
        'Quản lý tất cả tin nhắn, bình luận',
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1.color,
        ),
      ),
      trailing: Badge(
        padding: EdgeInsets.all(Layouts.SPACING / 2),
        badgeContent: Text(
          '$notificationCount',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        showBadge: notificationCount > 0 ? true : false,
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<Conversations>.value(
            value: AzsalesData
                .instance.conversations.map[PlatformConversation.all],
            child: AllMessageScreen(),
          ),
        ),
      ),
    );
  }

  Widget _facebook(BuildContext context) {
    int notificationCount = 1;
    notificationCount = min(notificationCount, 999);
    return ListTile(
      leading: Image(
        height: 60,
        width: 60,
        image: AssetImage(Images.FACEBOOK),
      ),
      title: Text('Facebook'),
      subtitle: Text(
        'Quản lý tin nhắn, bình luận',
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1.color,
        ),
      ),
      trailing: Badge(
        padding: EdgeInsets.all(Layouts.SPACING / 2),
        badgeContent: Text(
          '$notificationCount',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        showBadge: notificationCount > 0 ? true : false,
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<Conversations>.value(
            value: AzsalesData
                .instance.conversations.map[PlatformConversation.facebook],
            child: FacebookMessageScreen(),
          ),
        ),
      ),
    );
  }

  Widget _zalo(BuildContext context) {
    int notificationCount = 0;
    notificationCount = min(notificationCount, 999);
    return ListTile(
      leading: Image(
        height: 60,
        width: 60,
        image: AssetImage(Images.ZALO),
      ),
      title: Text('Zalo'),
      subtitle: Text(
        'Quản lý tin nhắn',
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1.color,
        ),
      ),
      trailing: Badge(
        padding: EdgeInsets.all(Layouts.SPACING / 2),
        badgeContent: Text(
          '$notificationCount',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        showBadge: notificationCount > 0 ? true : false,
      ),
      onTap: () => {},
    );
  }
}
