import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;

//Components
import 'package:cntt2_crm/components/circle_avatar_with_platform.dart';

//Models

class ProfileCustomerScreen extends StatelessWidget {
  final String customerName;
  final String customerId;

  const ProfileCustomerScreen({
    Key key,
    @required this.customerName,
    @required this.customerId,
  }) : super(key: key);
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
            CircleAvatarWithPlatform(),
            SizedBox(
              height: Layouts.SPACING,
            ),
            Text(
              customerName,
              style: TextStyle(fontSize: Fonts.SIZE_TEXT_LARGE),
            ),
          ],
        ),
      ),
    );
  }
}
