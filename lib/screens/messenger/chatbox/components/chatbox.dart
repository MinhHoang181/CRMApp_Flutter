import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/list_model/MessageList.dart';

//Components
import 'chat_input_field.dart';
import 'message.dart';

class ChatBox extends StatelessWidget {
  final RefreshController _refreshController = RefreshController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _chatlog(context),
        ChatInputField(
          scrollController: _scrollController,
        ),
      ],
    );
  }

  void _onLoading(MessageList messageList) async {
    bool check = await messageList.loadMoreData();
    if (check) {
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }

  Widget _chatlog(BuildContext context) {
    final chatlog = Provider.of<MessageList>(context);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Layouts.SPACING),
        child: SmartRefresher(
          enablePullDown: false,
          enablePullUp: true,
          footer: CustomFooter(
            loadStyle: LoadStyle.ShowAlways,
            builder: (context, mode) {
              if (mode == LoadStatus.loading) {
                return Container(
                  height: 60.0,
                  child: Container(
                    height: 20.0,
                    width: 20.0,
                    child: CupertinoActivityIndicator(),
                  ),
                );
              } else
                return Container();
            },
          ),
          onLoading: () => _onLoading(chatlog),
          controller: _refreshController,
          child: ListView.builder(
            controller: _scrollController,
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
