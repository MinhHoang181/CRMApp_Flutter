import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
//Conponents
import 'chat_input_field.dart';
import 'message.dart';

//Model
import 'package:cntt2_crm/models/ChatMessage.dart';

class Body extends StatelessWidget {
  final List<ChatMessage> chatlog;

  const Body({Key key, @required this.chatlog}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ChatLog(chatlog: chatlog),
        ChatInputField(),
      ],
    );
  }
}

class _ChatLog extends StatelessWidget {
  final List<ChatMessage> chatlog;

  const _ChatLog({Key key, @required this.chatlog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Layouts.SPACING),
        child: ListView.builder(
          reverse: true,
          itemCount: chatlog.length,
          itemBuilder: (context, index) {
            return _buildRow(index);
          },
        ),
      ),
    );
  }

  Widget _buildRow(int index) {
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
