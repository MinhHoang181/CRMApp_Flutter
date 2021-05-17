import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/ChatMessage.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({Key key, this.message}) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1),
      padding: EdgeInsets.symmetric(
        horizontal: Layouts.SPACING * 0.75,
        vertical: Layouts.SPACING / 2,
      ),
      decoration: BoxDecoration(
        color: message.isSender
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        message.text,
        style: TextStyle(
          color: message.isSender
              ? Colors.white
              : Theme.of(context).textTheme.bodyText1.color,
        ),
      ),
    );
  }
}
