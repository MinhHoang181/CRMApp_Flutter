import 'package:flutter/material.dart';

//Components
import 'components/body.dart';

class OverallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _overallScreenAppBar(context),
      body: Body(),
    );
  }

  AppBar _overallScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'AZSales',
        style: Theme.of(context).textTheme.headline1,
      ),
      flexibleSpace: Image(
        image: AssetImage('assets/images/appbar-background.png'),
        fit: BoxFit.cover,
      ),
      elevation: 0,
    );
  }
}
