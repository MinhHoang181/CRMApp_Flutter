import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
//Conponents
import 'chat_input_field.dart';
import 'message.dart';

//Model
import 'package:cntt2_crm/models/testModels.dart';

class Body extends StatelessWidget {
  const Body({Key key, @required this.avatar}) : super(key: key);

  final String avatar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ChatLog(
          avatar: avatar,
        ),
        ChatInputField(),
      ],
    );
  }
}

class _ChatLog extends StatelessWidget {
  const _ChatLog({Key key, @required this.avatar}) : super(key: key);

  final String avatar;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Layouts.SPACING),
        child: ListView.builder(
          reverse: true,
          itemCount: testCustomer.chatLogs.length,
          itemBuilder: (context, index) {
            return _buildRow(index);
          },
        ),
      ),
    );
  }

  Widget _buildRow(int index) {
    bool _isMutilLine = false;
    if (!testCustomer.chatLogs[index].isSender && index != 0) {
      _isMutilLine = !testCustomer.chatLogs[index - 1].isSender;
    }
    return Message(
      message: testCustomer.chatLogs[index],
      avatar: avatar,
      isMutilLine: _isMutilLine,
    );
  }
}
