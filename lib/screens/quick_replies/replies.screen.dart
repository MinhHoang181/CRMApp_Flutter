import 'package:cntt2_crm/models/QuickReply.dart';
import 'package:cntt2_crm/models/list_model/ReplyList.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//Components
import 'components/reply_item.dart';

//Models
import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';

//Screens
import 'reply_detail.screen.dart';

class RepliesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _answersScreenAppBar(context),
      body: Container(
        margin: EdgeInsets.only(top: Layouts.SPACING),
        child: ChangeNotifierProvider<ReplyList>.value(
          value: AzsalesData.instance.replies,
          child: _ListReply(),
        ),
      ),
    );
  }

  AppBar _answersScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Tin trả lời lưu sẵn'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReplyDetailScreen(),
            ),
          ),
        ),
      ],
    );
  }
}

class _ListReply extends StatelessWidget {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    final replies = Provider.of<ReplyList>(context);
    return SmartRefresher(
      header: ClassicHeader(
        idleText: 'Kéo xuống để làm mới danh sách tin nhắn mẫu',
        releaseText: 'Thả ra để làm mới danh sách tin nhắn mẫu',
        refreshingText: 'Đang làm mới danh sách tin nhắn mẫu',
        completeText: 'Đã làm mới danh sách tin nhắn mẫu',
        failedText: 'Làm mới danh sách tin nhắn mẫu thất bại',
      ),
      onRefresh: _onRefresh,
      controller: _refreshController,
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: replies.map.length,
        itemBuilder: (context, index) =>
            ChangeNotifierProvider<QuickReply>.value(
          value: replies.map.values.elementAt(index),
          child: ReplyItem(),
        ),
      ),
    );
  }

  void _onRefresh() async {
    await AzsalesData.instance.replies.refreshData();
    _refreshController.refreshCompleted();
  }
}
