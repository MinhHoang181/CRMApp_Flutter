import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
//Model
import 'package:cntt2_crm/models/ChatMessage.dart';

//Components
import 'message/text_message.dart';

class Message extends StatelessWidget {
  const Message({
    Key key,
    @required this.message,
    @required this.avatar,
  }) : super(key: key);

  final ChatMessage message;
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!message.isSender) ...[
          CircleAvatar(
            backgroundImage: NetworkImage(avatar),
            radius: 12,
          ),
          SizedBox(
            width: Layouts.SPACING / 2,
          )
        ],
        TextMessage(
          message: message,
        ),
      ],
    );
  }
}
