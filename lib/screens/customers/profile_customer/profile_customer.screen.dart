import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;

//Components
import 'package:cntt2_crm/components/circle_avatar_with_platform.dart';

//Models
import 'package:cntt2_crm/models/Customer.dart';

class ProfileCustomerScreen extends StatelessWidget {
  final Customer customer;

  const ProfileCustomerScreen({Key key, @required this.customer})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _profileCustomerScreenAppBar(context),
      body: Center(
        child: Text('Profile'),
      ),
    );
  }

  AppBar _profileCustomerScreenAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 120,
      title: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatarWithPlatform(
              image: customer.avatar,
            ),
            SizedBox(
              height: Layouts.SPACING,
            ),
            Text(
              customer.name,
              style: TextStyle(fontSize: Fonts.SIZE_TEXT_LARGE),
            ),
          ],
        ),
      ),
    );
  }
}
