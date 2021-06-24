import 'package:cntt2_crm/screens/overall/components/background.dart';
import 'package:flutter/material.dart';

//Components
import 'user_info.dart';
import 'setting/setting.dart';

class Body extends StatelessWidget {

  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _controller = ScrollController();
    return Stack(
      children: [
        Background(scrollController: _controller),
        CustomScrollView(
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
        )
      ],
    );
  }
}
