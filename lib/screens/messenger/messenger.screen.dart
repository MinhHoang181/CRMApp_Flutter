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
          ChangeNotifierProvider<Conversations>.value(
            value: AzsalesData
                .instance.conversations.map[PlatformConversation.all],
            child: _All(),
          ),
          Divider(),
          ChangeNotifierProvider<Conversations>.value(
            value: AzsalesData
                .instance.conversations.map[PlatformConversation.facebook],
            child: _Facebook(),
          ),
          Divider(),
          ChangeNotifierProvider<Conversations>.value(
            value: null,
            child: _Zalo(),
          ),
        ],
      ),
    );
  }
}

class _All extends StatelessWidget {
  const _All({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conversations = context.watch<Conversations>();
    final notificationCount = min(conversations.unreadCount, 999);
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
            value: conversations,
            child: AllMessageScreen(),
          ),
        ),
      ),
    );
  }
}

class _Facebook extends StatelessWidget {
  const _Facebook({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conversations = context.watch<Conversations>();
    final notificationCount = min(conversations.unreadCount, 999);
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
            value: conversations,
            child: FacebookMessageScreen(),
          ),
        ),
      ),
    );
  }
}

class _Zalo extends StatelessWidget {
  const _Zalo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final conversations = context.watch<Conversations>();
    final notificationCount = min(0, 999);
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
