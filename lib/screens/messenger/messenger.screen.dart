import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/enum.dart';
import 'package:cntt2_crm/constants/icons.dart' as _Icons;
import 'package:badges/badges.dart';

//Screen
import 'list_messenger/facebook_messenger.screen.dart';

class MessengerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _messengerScreenAppBar(context),
      body: _ListPlatform(),
    );
  }

  AppBar _messengerScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Quản lý tin nhắn'),
    );
  }
}

class _ListPlatform extends StatefulWidget {
  @override
  __ListPlatformState createState() => __ListPlatformState();
}

class __ListPlatformState extends State<_ListPlatform> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Layouts.SPACING),
      child: ListView(
        children: [
          _platform(Platform.facebook, 10, FacebookMessengerScreen()),
          Divider(),
          _platform(Platform.zalo, 0, null),
          Divider(),
        ],
      ),
    );
  }

  Widget _platform(Platform platform, int notificationCount, Widget toPage) {
    var _image = AssetImage('');
    notificationCount = min(notificationCount, 999);
    switch (platform) {
      case Platform.facebook:
        _image = AssetImage(_Icons.FACEBOOK);
        break;
      case Platform.zalo:
        _image = AssetImage(_Icons.ZALO);
        break;
      default:
        break;
    }
    return ListTile(
      leading: Image(
        image: _image,
      ),
      title: Text('Facebook'),
      subtitle: Text('Quản lý tập trung tin nhắn'),
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
      onTap: toPage != null
          ? () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => toPage,
                ),
              )
          : null,
    );
  }
}
