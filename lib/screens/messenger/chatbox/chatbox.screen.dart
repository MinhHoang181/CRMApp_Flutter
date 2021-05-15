import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/enum.dart';
import 'package:cntt2_crm/components/circle_avatar_with_platform.dart';

class ChatboxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatboxScreenAppBar(context),
      body: Center(
        child: Text('Chatbox'),
      ),
    );
  }

  AppBar chatboxScreenAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          BackButton(),
          CircleAvatarWithPlatform(
            image: 'https://scontent-hkg4-1.xx.fbcdn.net/v/t1.6435-9/39993392_1471420126335352_496738737586176000_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=H4B06kRDkd0AX8S-gd5&_nc_ht=scontent-hkg4-1.xx&oh=58b7916825248a283462e907017108f9&oe=60C4CD3D',
            radius: 24,
            platform: Platform.messenger,
            isActive: true,
          ),
        ],
      )
    );
  }
}
