import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:provider/provider.dart';
//Conponents
import 'chat_input_field.dart';
import 'message.dart';

//Model
import 'package:cntt2_crm/models/list_model/MessageList.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ChatLog(),
        ChatInputField(),
      ],
    );
  }
}

class _ChatLog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatlog = Provider.of<MessageList>(context).list;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Layouts.SPACING),
        child: ListView.builder(
          reverse: true,
          itemCount: chatlog.length,
          itemBuilder: (context, index) {
            return _buildRow(context, index);
          },
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, int index) {
    final chatlog = Provider.of<MessageList>(context).list;
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
