import 'package:cntt2_crm/screens/login/login.screen.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

class Setting extends StatefulWidget {
  const Setting({Key key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Layouts.SPACING),
      child: Card(
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _logout(),
          ],
        ),
      ),
    );
  }

  Widget _logout() {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(Layouts.SPACING),
        child: Row(
          children: [
            Icon(Icons.logout_rounded),
            SizedBox(width: Layouts.SPACING / 2),
            Text('Đăng xuất'),
          ],
        ),
      ),
      onTap: () => showDialog(
        context: context,
        builder: (context) => _logoutDialog(),
      ),
    );
  }

  Widget _logoutDialog() {
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
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}
