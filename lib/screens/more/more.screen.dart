import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('More Page'),
    );
  }

  static AppBar moreScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Orders'),
    );
  }
}