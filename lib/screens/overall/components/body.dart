import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

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
            SizedBox(height: Layouts.SPACING),
            PlatformInfo(),
            SizedBox(height: Layouts.SPACING),
            OrdersPending(),
          ],
        ),
      ),
    );
  }
}
