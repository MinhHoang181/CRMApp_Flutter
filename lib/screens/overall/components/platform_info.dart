import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/images.dart' as MyImages;
import 'package:cntt2_crm/constants/icons.dart' as MyIcons;
import 'package:provider/provider.dart';

//Models
import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/Facebook/FacebookConversations.dart';
import 'package:cntt2_crm/models/list_model/ConversationList.dart';
import 'package:cntt2_crm/models/Conversation/Conversations.dart';

class PlatformInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final facebook =
        AzsalesData.instance.conversations.map[PlatformConversation.facebook];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: Layouts.SPACING,
            left: Layouts.SPACING,
            right: Layouts.SPACING,
          ),
          padding: EdgeInsets.symmetric(horizontal: Layouts.SPACING),
          child: Text(
            'Thông tin nền tảng',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(
          height: Layouts.SPACING,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: Layouts.SPACING),
          padding: EdgeInsets.all(Layouts.SPACING),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                offset: Offset(0, 3),
                color: Theme.of(context).shadowColor,
              ),
            ],
          ),
          child: Column(
            children: [
              ChangeNotifierProvider<Conversations>.value(
                value: facebook,
                child: _PlatformRow(name: 'Facebook', logo: MyImages.FACEBOOK),
              ),
              Divider(),
              ChangeNotifierProvider<Conversations>.value(
                value: null,
                child: _PlatformRow(name: 'Zalo', logo: MyImages.ZALO),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlatformRow extends StatelessWidget {
  final String name;
  final String logo;
  const _PlatformRow({Key key, @required this.name, @required this.logo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final platform = context.watch<Conversations>();
    return Container(
      margin: EdgeInsets.symmetric(vertical: Layouts.SPACING / 2),
      child: Column(
        children: [
          Row(
            children: [
              Image(
                image: AssetImage(logo),
                width: 50,
                height: 50,
              ),
              SizedBox(
                width: Layouts.SPACING,
              ),
              Text(
                name,
                style: Theme.of(context).textTheme.subtitle1,
              )
            ],
          ),
          SizedBox(
            height: Layouts.SPACING,
          ),
          Row(
            children: [
              SizedBox(
                width: 32,
                height: 32,
                child: Image(
                  image: AssetImage(MyIcons.CONVERSATION2),
                ),
              ),
              SizedBox(
                width: Layouts.SPACING,
              ),
              Text(
                'Tin nhắn',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Spacer(),
              _alertText(
                context,
                platform != null ? platform.unreadCount : 0,
                'tin nhắn',
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SizedBox(
                width: 27,
                height: 27,
                child: Image(
                  image: AssetImage(MyIcons.BELL2),
                ),
              ),
              SizedBox(
                width: Layouts.SPACING,
              ),
              Text(
                'Thông báo',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Spacer(),
              _alertText(context, 0, 'thông báo'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _alertText(BuildContext context, int numberAlert, String name) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Text(
            numberAlert > 0 ? '$numberAlert chưa đọc' : '0 $name mới',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            width: Layouts.SPACING / 2,
          ),
          Icon(
            Icons.circle,
            size: 10,
            color: numberAlert > 0 ? Colors.red : Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}
