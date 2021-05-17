import 'package:flutter/material.dart';

class SelectTagScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: selectTagScreenAppBar(context),
      body: Center(
        child: Text('Tag'),
      ),
    );
  }

  AppBar selectTagScreenAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text('Gắn nhãn tin nhắn'),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => {}),
      ],
    );
  }
}
