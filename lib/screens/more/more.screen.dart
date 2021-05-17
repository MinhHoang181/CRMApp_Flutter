import 'package:flutter/material.dart';

//test
import 'package:cntt2_crm/screens/messenger/chatbox/chatbox.screen.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: moreScreenAppBar(context),
      body: Center(
        child: IconButton(
          icon: Icon(Icons.messenger),
          iconSize: 100,
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatboxScreen(),
              )
          ),
        ),
      ),
    );
  }

  static AppBar moreScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('More'),
    );
  }
}