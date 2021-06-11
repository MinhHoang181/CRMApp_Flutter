import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:provider/provider.dart';
//Conponents
import 'chat_input_field.dart';
import 'message.dart';

//Model
import 'package:cntt2_crm/models/ChatMessage.dart';
import 'package:cntt2_crm/models/Paging/MessagePage.dart';

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
    final chatlog = Provider.of<MessagePage>(context);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Layouts.SPACING),
        child: ListView.builder(
          reverse: true,
          itemCount: chatlog.list.length,
          itemBuilder: (context, index) {
            return _buildRow(chatlog.list.values.toList(), index);
          },
        ),
      ),
    );
  }

  Widget _buildRow(List<ChatMessage> chatlog, int index) {
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
