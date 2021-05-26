import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/ChatMessage.dart';

class StickerMessage extends StatelessWidget {
  final ChatMessage message;

  const StickerMessage({Key key, @required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: message.isSender
          ? EdgeInsets.only(
              top: 1,
              left: Layouts.SPACING * 4,
            )
          : EdgeInsets.only(
              top: 1,
              right: Layouts.SPACING * 4,
            ),
      child: SizedBox(
        height: 100,
        width: 100,
        child: Image(
          image: NetworkImage(message.sticker),
        ),
      ),
    );
  }
}
