import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/list_model/LabelList.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Screens
import 'package:cntt2_crm/screens/labels/labels.screen.dart';
import 'package:cntt2_crm/screens/login/login.screen.dart';
import 'package:provider/provider.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Layouts.SPACING),
      child: Card(
        elevation: 10,
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
            _labels(context),
            _logout(context),
          ],
        ),
      ),
    );
  }

  Widget _labels(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.all(Layouts.SPACING),
        child: Row(
          children: [
            Icon(Icons.style_rounded),
            SizedBox(width: Layouts.SPACING),
            Text('Quản lý nhãn'),
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

  Widget _logout(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.all(Layouts.SPACING),
        child: Row(
          children: [
            Icon(Icons.logout_rounded),
            SizedBox(width: Layouts.SPACING),
            Text('Đăng xuất'),
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
      content: Text('Bạn muốn đăng xuất?'),
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
