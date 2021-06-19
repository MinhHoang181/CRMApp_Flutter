import 'package:cntt2_crm/models/ChatMessage.dart';
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
    final messageList = Provider.of<MessageList>(context);
    final chatlog = messageList.list;
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
          onLoading: () => _onLoading(messageList),
          controller: _refreshController,
          child: ListView.builder(
            controller: _scrollController,
            reverse: true,
            itemCount: chatlog.length,
            itemBuilder: (context, index) {
              return _buildRow(context, chatlog, index);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, List<ChatMessage> chatlog, int index) {
    bool _isMutilLine = false;
    if (!chatlog[index].isSender && index != 0) {
      _isMutilLine = !chatlog[index - 1].isSender;
    } else if (chatlog[index].isSender && index != 0) {
      _isMutilLine = chatlog[index - 1].isSender;
    }
    return Message(
      message: chatlog[index],
      isMutilLine: _isMutilLine,
    );
  }
}
