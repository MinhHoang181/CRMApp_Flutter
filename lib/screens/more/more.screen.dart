import 'package:flutter/material.dart';

//Components
import 'components/body.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _moreScreenAppBar(context),
      body: Body(),
    );
  }

  AppBar _moreScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Cài đặt'),

      flexibleSpace: Image(
        image: AssetImage('assets/images/appbar-background.png'),
        fit: BoxFit.cover,
      ),
      elevation: 0,
    );
  }
}
