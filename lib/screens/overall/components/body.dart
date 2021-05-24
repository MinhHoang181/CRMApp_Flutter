import 'package:flutter/material.dart';

//Components
import 'sales_info.dart';
import 'platform_info.dart';
import 'order_pending.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SalesInfo(),
            PlatformInfo(),
            OrdersPending(),
          ],
        ),
      ),
    );
  }
}
