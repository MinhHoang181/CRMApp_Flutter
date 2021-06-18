import 'package:flutter/material.dart';

//Components
import 'sales_info.dart';
import 'platform_info.dart';
import 'shortcut_item.dart';
import 'order_pending.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            SalesInfo(),
            ShortCut(),
            PlatformInfo(),
            OrdersPending(),
            SizedBox(
              height: 17,
            )
          ],
        ),
      ),
    );
  }
}
