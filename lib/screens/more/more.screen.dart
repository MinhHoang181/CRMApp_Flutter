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
      title: Text('More'),
    );
  }
}
