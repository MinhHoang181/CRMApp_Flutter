import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/images.dart' as Images;
import 'package:cntt2_crm/constants/icons.dart' as MyIcons;
import 'package:cntt2_crm/constants/enum.dart';

//Models
import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/Facebook/FacebookConversations.dart';
import 'package:cntt2_crm/models/list_model/ConversationList.dart';

class PlatformInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FacebookConversations facebook =
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
              _platformRow(context, Platform.facebook, facebook.unreadCount, 0),
              Divider(),
              _platformRow(context, Platform.zalo, 0, 0),
            ],
          ),
        ),
      ],
    );
  }

  Widget _platformRow(
    BuildContext context,
    Platform platform,
    int numberMess,
    int numberNotifi,
  ) {
    String _namePlatform;
    String _logoPlatform;
    switch (platform) {
      case Platform.facebook:
        {
          _namePlatform = 'Facebook';
          _logoPlatform = Images.FACEBOOK;
          break;
        }
      case Platform.zalo:
        {
          _namePlatform = 'Zalo';
          _logoPlatform = Images.ZALO;
          break;
        }
      default:
        break;
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: Layouts.SPACING / 2),
      child: Column(
        children: [
          Row(
            children: [
              Image(
                image: AssetImage(_logoPlatform),
                width: 50,
                height: 50,
              ),
              SizedBox(
                width: Layouts.SPACING,
              ),
              Text(
                _namePlatform,
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
              _alertText(context, numberMess, 'tin nhắn'),
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
              _alertText(context, numberNotifi, 'thông báo'),
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
            numberAlert > 0 ? '$numberAlert chưa đọc' : 'Không có $name mới',
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
