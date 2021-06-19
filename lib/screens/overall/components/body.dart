import 'package:flutter/material.dart';

//Components
import 'sales_info.dart';
import 'platform_info.dart';
import 'shortcut_item.dart';
import 'order_pending.dart';
import 'background.dart';

class Body extends StatelessWidget {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(scrollController: _controller),
        SingleChildScrollView(
          controller: _controller,
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
        ),
      ],
    );
  }
}
