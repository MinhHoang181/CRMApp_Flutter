import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/screens/components/image_item.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/models/Facebook/FacebookPage.dart';

//Components
import 'package:cntt2_crm/screens/components/circle_avatar_with_platform.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Layouts.SPACING,
      ),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(Layouts.SPACING),
          child: Column(
            children: [
              _userInfo(context),
              SizedBox(
                height: 10,
              ),
              Divider(),
              _listPage(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userInfo(BuildContext context) {
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

  Widget _listPage(BuildContext context) {
    final pages = AzsalesData.instance.pages;
    return pages.map.isEmpty
        ? _noConnectPage(context)
        : ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: List.generate(
              pages.map.length,
              (index) => _itemPage(context, pages.map.values.elementAt(index)),
            ),
          );
  }

  Widget _itemPage(BuildContext context, FacebookPage page) {
    return Container(
      padding: const EdgeInsets.all(Layouts.SPACING),
      child: Row(
        children: [
          ImageItem(
            url: page.imageUrl,
            border: 1,
          ),
          SizedBox(
            width: Layouts.SPACING,
          ),
          Text(
            page.name,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  fontSize: Theme.of(context).textTheme.subtitle1.fontSize - 3,
                ),
          ),
        ],
      ),
    );
  }

  Widget _noConnectPage(BuildContext context) {
    return Column(
      children: [
        Text(
          'Bạn chưa liên kết với bất kì Page nào.',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(height: Layouts.SPACING / 2),
        Text(
          'Chuyển sang facebook?',
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
