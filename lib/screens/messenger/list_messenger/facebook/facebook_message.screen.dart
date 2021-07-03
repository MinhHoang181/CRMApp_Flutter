import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Components
import '../components/body.dart';
import 'components/page_select.dart';

//Models
import 'package:cntt2_crm/models/Conversation/FilterConversation.dart';

class FacebookMessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _facebookMessengerScreenAppBar(),
        body: SafeArea(
          child: TabBarView(
            children: [
              Provider.value(
                value: FilterConversation.all,
                child: Body(),
              ),
              Provider.value(
                value: FilterConversation.unread,
                child: Body(),
              ),
              Provider.value(
                value: FilterConversation.unreplied,
                child: Body(),
              ),
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
                text: 'Chưa xem',
              ),
              Tab(
                text: 'Chưa trả lời',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
