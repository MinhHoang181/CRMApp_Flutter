import 'package:badges/badges.dart';
import 'package:cntt2_crm/constants/enum.dart';
import 'package:cntt2_crm/models/Facebook/FacebookPage.dart';

import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/Conversation/Conversation.dart';
import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/Label.dart';

//Components
import 'package:cntt2_crm/screens/components/circle_avatar_with_platform.dart';
import 'package:cntt2_crm/screens/components/image_item.dart';

//Screens
import 'package:cntt2_crm/screens/messenger/chatbox/chatbox.screen.dart';
import 'package:provider/provider.dart';

class ConversationItem extends StatelessWidget {
  const ConversationItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conversation = Provider.of<Conversation>(context);
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(Layouts.SPACING / 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _avatar(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(Layouts.SPACING / 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _message(context, conversation),
                    SizedBox(height: Layouts.SPACING / 2),
                    _labelList(context, conversation.labelIds),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        if (!conversation.isRead) conversation.setIsRead();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider.value(
              value: conversation,
              child: ChatboxScreen(),
            ),
          ),
        );
      },
    );
  }

  Widget _avatar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Layouts.SPACING),
      child: CircleAvatarWithPlatform(
        platform: Platform.messenger,
        radius: 30,
      ),
    );
  }

  Widget _message(BuildContext context, Conversation conversation) {
    final FacebookPage page =
        AzsalesData.instance.pages.map[conversation.pageId];
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: Layouts.SPACING / 2,
                children: [
                  Text(
                    conversation.participants[0].name,
                    style: conversation.isRead
                        ? Theme.of(context).textTheme.bodyText2.copyWith(
                              fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .fontSize +
                                  2,
                            )
                        : Theme.of(context).textTheme.bodyText2.copyWith(
                              fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .fontSize +
                                  2,
                              fontWeight: FontWeight.w900,
                            ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .color
                        .withOpacity(0.5),
                    size: 14,
                  ),
                  ImageItem(
                    url: page.imageUrl,
                    size: const Size(25, 25),
                    circle: true,
                    border: 1,
                  ),
                ],
              ),
              SizedBox(height: Layouts.SPACING / 2),
              Text(
                conversation.isReplied
                    ? 'Bạn: ' + conversation.snippet
                    : conversation.snippet,
                style: conversation.isRead
                    ? Theme.of(context).textTheme.bodyText2
                    : Theme.of(context).textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(width: Layouts.SPACING),
        _moreInfo(conversation),
      ],
    );
  }

  Widget _labelList(BuildContext context, List<String> labelIds) {
    return Wrap(
      children: List.generate(
        labelIds.length,
        (index) => _labelItem(labelIds[index]),
      ),
    );
  }

  Widget _labelItem(String labelId) {
    Label label = AzsalesData.instance.labels.map[labelId];
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Layouts.SPACING / 6,
        vertical: Layouts.SPACING / 6,
      ),
      child: Badge(
        badgeColor: label.color.withOpacity(0.6),
        toAnimate: false,
        shape: BadgeShape.square,
        borderRadius: BorderRadius.circular(20),
        badgeContent: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.circle,
              color: label.color,
              size: 8,
            ),
            SizedBox(width: Layouts.SPACING / 4),
            Text(
              label.name,
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _moreInfo(Conversation conversation) {
    final double size = 15;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(conversation.dateUpdate),
        SizedBox(height: Layouts.SPACING / 2),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (conversation.hasPhone) ...[
              Icon(
                Icons.phone_rounded,
                size: size,
              ),
              SizedBox(width: Layouts.SPACING / 4),
            ],
            if (conversation.hasNote) ...[
              Icon(
                Icons.note_rounded,
                size: size,
              ),
              SizedBox(width: Layouts.SPACING / 4),
            ],
            if (conversation.hasOrder) ...[
              Icon(
                Icons.shopping_cart_sharp,
                size: size,
              ),
              SizedBox(width: Layouts.SPACING / 4),
            ],
          ],
        ),
      ],
    );
  }
}
