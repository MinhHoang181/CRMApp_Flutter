import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:provider/provider.dart';
//Conponents
import 'chat_input_field.dart';
import 'message.dart';

//Model
import 'package:cntt2_crm/models/ChatMessage.dart';

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
    final chatlog = Provider.of<Messages>(context);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Layouts.SPACING),
        child: ListView.builder(
          reverse: true,
          itemCount: chatlog.messages.length,
          itemBuilder: (context, index) {
            return _buildRow(chatlog, index);
          },
        ),
      ),
    );
  }

  Widget _buildRow(Messages chatlog, int index) {
    bool _isMutilLine = false;
    if (!chatlog.messages[index].isSender && index != 0) {
      _isMutilLine = !chatlog.messages[index - 1].isSender;
    } else if (chatlog.messages[index].isSender && index != 0) {
      _isMutilLine = chatlog.messages[index - 1].isSender;
    }
    return Message(
      message: chatlog.messages[index],
      isMutilLine: _isMutilLine,
    );
  }
}
