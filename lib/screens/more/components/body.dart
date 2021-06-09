import 'package:flutter/material.dart';

//Components
import 'user_info.dart';
import 'setting.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              UserInfo(),
              Setting(),
            ],
          ),
        ),
      ],
    );
  }
}
