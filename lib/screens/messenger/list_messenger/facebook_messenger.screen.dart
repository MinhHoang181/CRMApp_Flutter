import 'package:flutter/material.dart';

//Components
import 'components/body.dart';
import 'components/page_select.dart';

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
        body: SafeArea(
          child: TabBarView(
            children: [
              Body(),
              Container(),
              Container(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _facebookMessengerScreenAppBar() {
    return AppBar(
      centerTitle: false,
      title: Text('Facebook'),
      actions: [
        PageSelect(),
        IconButton(
          icon: Icon(Icons.search_rounded),
          onPressed: () => {},
        ),
        IconButton(
          icon: Icon(Icons.more_vert_rounded),
          onPressed: () => {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: _tabBar(),
      ),
    );
  }

  Widget _tabBar() {
    return Row(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                text: 'Tất cả',
              ),
              Tab(
                text: 'Tin nhắn',
              ),
              Tab(
                text: 'Bình luận',
              ),
            ],
          ),
        ),
        Spacer(),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Icon(Icons.filter_alt_rounded),
            color: Colors.white,
            onPressed: () => {},
          ),
        )
      ],
    );
  }
}
