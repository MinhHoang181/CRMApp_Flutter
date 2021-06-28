import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;
import 'package:cntt2_crm/components/image_item.dart';

//Models
import 'package:cntt2_crm/models/ChatMessage.dart';
import 'package:flutter/rendering.dart';

class AttachmentMessage extends StatelessWidget {
  final ChatMessage message;

  const AttachmentMessage({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        if (message.message.isNotEmpty) ...[
          _text(context),
        ],
        Wrap(
          children: List.generate(
            message.attachments.length,
            (index) => _getAttachment(context, message.attachments[index]),
          ),
        ),
      ],
    );
  }

  Widget _text(BuildContext context) {
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
        message.message,
        style: TextStyle(
          color: message.isSender
              ? Colors.white
              : Theme.of(context).textTheme.bodyText1.color,
          fontSize: Fonts.SIZE_TEXT_MEDIUM,
        ),
      ),
    );
  }

  Widget _getAttachment(BuildContext context, Attachment attachment) {
    switch (attachment.attachmentType) {
      case AttachmentType.image:
        return _image(attachment.url);
      case AttachmentType.sticker:
        return _sticker(attachment.url);
      default:
        return SizedBox.shrink();
    }
  }

  Widget _image(String url) {
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ImageItem(
          url: url,
          size: const Size(200, 200),
        ),
      ),
    );
  }

  Widget _sticker(String url) {
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
          image: NetworkImage(url),
        ),
      ),
    );
  }
}
