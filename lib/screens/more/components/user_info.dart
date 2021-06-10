import 'package:cntt2_crm/models/AzsalesData.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

import 'package:cntt2_crm/models/Facebook/FacebookPage.dart';

//Components
import 'package:cntt2_crm/components/circle_avatar_with_platform.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Layouts.SPACING),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.all(Layouts.SPACING),
          child: Column(
            children: [
              _userInfo(),
              Divider(),
              _listPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userInfo() {
    final user = AzsalesData.instance.azsalesAccount;
    return Row(
      children: [
        CircleAvatarWithPlatform(),
        SizedBox(width: Layouts.SPACING / 2),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.displayName == null ? '---' : user.displayName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              user.email == null ? '---' : user.email,
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .color
                    .withOpacity(0.7),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _listPage() {
    final pages = AzsalesData.instance.pages;
    return pages.isEmpty
        ? _noConnectPage()
        : ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: List.generate(
              pages.length,
              (index) => _itemPage(pages.values.elementAt(index)),
            ),
          );
  }

  Widget _itemPage(FacebookPage page) {
    return ListTile(
      title: Text(page.name),
    );
  }

  Widget _noConnectPage() {
    return Column(
      children: [
        Text(
          'Bạn chưa liên kết với bất kì Page nào.',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.7),
          ),
        ),
        SizedBox(height: Layouts.SPACING / 2),
        Text(
          'Chuyển sang facebook?',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
