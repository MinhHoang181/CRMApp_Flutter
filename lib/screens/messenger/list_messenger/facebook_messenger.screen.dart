import 'package:flutter/material.dart';

//Components
import 'components/body.dart';

class FacebookMessengerScreen extends StatefulWidget {
  @override
  _FacebookMessengerScreenState createState() =>
      _FacebookMessengerScreenState();
}

class _FacebookMessengerScreenState extends State<FacebookMessengerScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _facebookMessengerScreenAppBar(),
        body: TabBarView(
          children: [
            Body(),
            Body(),
            Container(),
          ],
        ),
      ),
    );
  }

  AppBar _facebookMessengerScreenAppBar() {
    return AppBar(
      centerTitle: false,
      title: Text('Tin nhắn'),
      actions: [
        IconButton(
          icon: Icon(Icons.search_rounded),
          onPressed: () => {},
        ),
        IconButton(
          icon: Icon(Icons.filter_alt_rounded),
          onPressed: () => {},
        ),
        IconButton(
          icon: Icon(Icons.more_vert_rounded),
          onPressed: () => {},
        ),
      ],
      bottom: _tabBar(),
    );
  }

  Widget _tabBar() {
    return TabBar(
      tabs: [
        Tab(
          icon: Icon(Icons.all_inbox_rounded),
          text: 'Tất cả',
        ),
        Tab(
          icon: Icon(Icons.inbox_rounded),
          text: 'Tin nhắn',
        ),
        Tab(
          icon: Icon(Icons.comment_rounded),
          text: 'Bình luận',
        ),
      ],
    );
  }
}
