import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/icons.dart' as MyIcons;
//Screens
import 'package:cntt2_crm/screens/labels/labels.screen.dart';
import 'package:cntt2_crm/screens/login/login.screen.dart';
import 'package:provider/provider.dart';
//Components
import 'components/darkModeSwitch.dart';
//Models
import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/list_model/LabelList.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Layouts.SPACING,
      ),
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: Layouts.SPACING,
                top: Layouts.SPACING,
              ),
              child: Text(
                'Cài đặt khác',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .color
                      .withOpacity(0.5),
                ),
              ),
            ),
            DarkModeSwitch(),
            _switchAccount(context),
            _labels(context),
            _update(context),
            _support(context),
            _logout(context),
          ],
        ),
      ),
    );
  }

  Widget _switchAccount(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(
            left: Layouts.SPACING,
            top: Layouts.SPACING,
            bottom: Layouts.SPACING / 2),
        child: Row(
          children: [
            SizedBox(
              width: 45,
              height: 45,
              child: Image(
                image: AssetImage(MyIcons.SWITCH_ACCOUNT_ICON),
              ),
            ),
            SizedBox(width: Layouts.SPACING),
            Text('Chuyển tài khoản',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _labels(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(
            left: Layouts.SPACING,
            top: Layouts.SPACING,
            bottom: Layouts.SPACING / 2),
        child: Row(
          children: [
            SizedBox(
              width: 45,
              height: 45,
              child: Image(
                image: AssetImage(MyIcons.TAG_ICON),
              ),
            ),
            SizedBox(width: Layouts.SPACING),
            Text('Quản lý nhãn',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 16)),
          ],
        ),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<LabelList>.value(
            value: AzsalesData.instance.labels,
            child: LabelsScreen(),
          ),
        ),
      ),
    );
  }

  Widget _update(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(
            left: Layouts.SPACING,
            top: Layouts.SPACING,
            bottom: Layouts.SPACING / 2),
        child: Row(
          children: [
            SizedBox(
              width: 45,
              height: 45,
              child: Image(
                image: AssetImage(MyIcons.UPDATE_ICON),
              ),
            ),
            SizedBox(width: Layouts.SPACING),
            Text(
              'Cập nhật ứng dụng',
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _support(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(
            left: Layouts.SPACING,
            top: Layouts.SPACING,
            bottom: Layouts.SPACING / 2),
        child: Row(
          children: [
            SizedBox(
              width: 45,
              height: 45,
              child: Image(
                image: AssetImage(MyIcons.SUPPORT),
              ),
            ),
            SizedBox(width: Layouts.SPACING),
            Text(
              'Chăm sóc khách hàng',
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logout(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(
            left: Layouts.SPACING,
            top: Layouts.SPACING,
            bottom: Layouts.SPACING),
        child: Row(
          children: [
            SizedBox(
              width: 45,
              height: 45,
              child: Image(
                image: AssetImage(MyIcons.SIGN_OUT),
              ),
            ),
            SizedBox(width: Layouts.SPACING),
            Text(
              'Đăng xuất',
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
            ),
          ],
        ),
      ),
      onTap: () => showDialog(
        context: context,
        builder: (context) => _logoutDialog(context),
      ),
    );
  }

  Widget _logoutDialog(BuildContext context) {
    return AlertDialog(
      content: Text(
        'Bạn muốn đăng xuất?',
        style: Theme.of(context).textTheme.subtitle1.copyWith(
              fontSize: Theme.of(context).textTheme.subtitle1.fontSize - 3,
            ),
      ),
      actions: [
        TextButton(
          child: Text('Hủy'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            'Đăng xuất',
            style: TextStyle(
              color: Theme.of(context).errorColor,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
              ModalRoute.withName('/'),
            );
          },
        ),
      ],
    );
  }
}
