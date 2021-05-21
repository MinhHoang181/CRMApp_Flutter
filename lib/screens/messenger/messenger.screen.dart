import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _messengerScreenAppBar(context),
      body: Center(
        child: Text('danh sach'),
      ),
    );
  }

  AppBar _messengerScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Danh sách tin nhắn'),
    );
  }
}
