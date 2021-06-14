import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//Models
import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/Paging/ConversationPage.dart';
import 'package:cntt2_crm/models/Conversation.dart';

//Components
import 'conversation_item.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  RefreshController _refreshController = RefreshController();

  void _onRefresh() async {
    await AzsalesData.instance.conversations.refreshData();
    _refreshController.refreshCompleted();
    setState(() {});
  }

  void _onLoading() async {
    bool check = await AzsalesData.instance.conversations.loadMoreData();
    if (check) {
      _refreshController.loadComplete();
      setState(() {});
    } else {
      _refreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ConversationPage>(
        future: AzsalesData.instance.conversations.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildList(snapshot.data);
          } else if (snapshot.hasError) {
            print(snapshot.error);
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  Widget _buildList(ConversationPage conversations) {
    return SmartRefresher(
      header: ClassicHeader(
        idleText: 'Kéo xuống để làm mới danh sách tin nhắn',
        releaseText: 'Thả ra để làm mới danh sách tin nhắn',
        refreshingText: 'Đang làm mới danh sách tin nhắn',
        completeText: 'Đã làm mới danh sách tin nhắn',
        failedText: 'Làm mới danh sách tin nhắn thất bại',
      ),
      enablePullUp: conversations.pageInfo.hasNextPage ? true : false,
      footer: ClassicFooter(
        canLoadingText: 'Tải thêm tin nhắn',
        loadingText: 'Đang tải thêm tin nhắn',
        noDataText: 'Đã tải hết tin nhắn',
        failedText: 'Tải tin nhắn thất bại',
      ),
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      controller: _refreshController,
      child: ListView.builder(
        itemCount: conversations.list.length,
        itemBuilder: (context, index) {
          final conversation = conversations.list.values.elementAt(index);
          return ChangeNotifierProvider<Conversation>.value(
            value: conversation,
            child: ConversationItem(),
          );
        },
      ),
    );
  }
}
