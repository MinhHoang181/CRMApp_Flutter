import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/enum.dart';
import 'package:cntt2_crm/components/circle_avatar_with_platform.dart';

//screen
import 'package:cntt2_crm/screens/tags/select_tag.screen.dart';
//components
import 'components/body.dart';

//test
final String testAvatar =
    'https://scontent.fhan5-5.fna.fbcdn.net/v/t1.6435-9/127647065_2858040844461205_173329872841937354_n.jpg?_nc_cat=107&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=LLyCWOvZgM4AX83eZ1X&_nc_ht=scontent.fhan5-5.fna&oh=0726dc574cf53b851efdc413d91ceaa9&oe=60C6FA86';

class ChatboxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatboxScreenAppBar(context),
      body: Body(
        avatar: testAvatar,
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
            image: testAvatar,
            radius: 22,
            platform: Platform.messenger,
            isActive: true,
          ),
          SizedBox(
            width: Layouts.SPACING * 0.75,
          ),
          Flexible(
            child: Text(
              'Lê Thanh Tú',
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
