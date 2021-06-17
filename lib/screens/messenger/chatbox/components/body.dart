import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
//Conponents
import 'message.dart';

//Model
import 'package:cntt2_crm/models/list_model/MessageList.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _ChatLog();
  }
}

class _ChatLog extends StatelessWidget {
  final RefreshController _refreshController = RefreshController();

  void _onLoading(MessageList messageList) async {
    bool check = await messageList.loadMoreData();
    if (check) {
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatlog = Provider.of<MessageList>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 60),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Layouts.SPACING),
        child: SmartRefresher(
          enablePullDown: false,
          enablePullUp: true,
          footer: ClassicFooter(),
          onLoading: () => _onLoading(chatlog),
          controller: _refreshController,
          child: ListView.builder(
            reverse: true,
            itemCount: chatlog.map.length,
            itemBuilder: (context, index) {
              return _buildRow(context, index);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, int index) {
    final chatlog = Provider.of<MessageList>(context);
    bool _isMutilLine = false;
    if (!chatlog.map.values.elementAt(index).isSender && index != 0) {
      _isMutilLine = !chatlog.map.values.elementAt(index - 1).isSender;
    } else if (chatlog.map.values.elementAt(index).isSender && index != 0) {
      _isMutilLine = chatlog.map.values.elementAt(index - 1).isSender;
    }
    return Message(
      message: chatlog.map.values.elementAt(index),
      isMutilLine: _isMutilLine,
    );
  }
}
