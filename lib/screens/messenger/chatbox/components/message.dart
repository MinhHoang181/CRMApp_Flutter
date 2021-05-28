import 'package:cntt2_crm/components/circle_avatar_with_platform.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
//Model
import 'package:cntt2_crm/models/ChatMessage.dart';

//Components
import 'message/text_message.dart';
import 'message/sticker_message.dart';
import 'message/attachment_message.dart';

class Message extends StatelessWidget {
  const Message({
    Key key,
    @required this.message,
    this.isMutilLine = false,
  }) : super(key: key);

  final ChatMessage message;
  final bool isMutilLine;

  Widget _getTypeMessage(ChatMessage message) {
    switch (message.messageType) {
      case MessageType.text:
        return TextMessage(message: message);
      case MessageType.sticker:
        return StickerMessage(message: message);
      case MessageType.attachment:
        return AttachmentMessage(message: message);
      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isMutilLine
          ? EdgeInsets.only(bottom: 0)
          : EdgeInsets.only(bottom: Layouts.SPACING),
      child: Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isSender) ...[
            Opacity(
              opacity: isMutilLine ? 0.0 : 1.0,
              child: CircleAvatarWithPlatform(
                radius: 12,
              ),
            ),
            SizedBox(width: Layouts.SPACING / 2),
          ],
          Flexible(
            child: _getTypeMessage(message),
          ),
        ],
      ),
    );
  }
}
