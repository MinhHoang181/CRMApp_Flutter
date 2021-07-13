import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;

//Models
import 'package:cntt2_crm/models/ChatMessage.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({Key key, this.message}) : super(key: key);

  final ChatMessage message;

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
        message.message.trim(),
        style: message.isSender
            ? Theme.of(context).textTheme.headline3.copyWith(
                  color: Colors.white,
                  fontSize: Fonts.SIZE_TEXT_MEDIUM,
                )
            : Theme.of(context).textTheme.headline3.copyWith(
                  color: AzsalesData.instance.ligthTheme
                      ? Colors.black
                      : Colors.white,
                  fontSize: Fonts.SIZE_TEXT_MEDIUM,
                ),
      ),
    );
  }
}
