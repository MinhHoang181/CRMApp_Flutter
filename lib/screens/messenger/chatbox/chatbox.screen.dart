import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/enum.dart';
import 'package:cntt2_crm/components/circle_avatar_with_platform.dart';

//screen
import 'package:cntt2_crm/screens/tags/select_tag.screen.dart';
//components
import 'components/body.dart';
//Models
import 'package:cntt2_crm/models/testModels.dart';

class ChatboxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatboxScreenAppBar(context),
      body: Body(
        avatar: testCustomer.avatar,
      ),
    );
  }

  AppBar chatboxScreenAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(),
          CircleAvatarWithPlatform(
            image: testCustomer.avatar,
            radius: 22,
            platform: Platform.messenger,
            isActive: true,
          ),
          SizedBox(
            width: Layouts.SPACING * 0.75,
          ),
          Flexible(
            child: Text(
              testCustomer.name,
              style: TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.style_rounded),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectTagScreen(),
              )),
        ),
        IconButton(
          icon: Icon(Icons.add_shopping_cart_rounded),
          onPressed: () => {},
        ),
        SizedBox(
          width: Layouts.SPACING / 2,
        )
      ],
    );
  }
}
