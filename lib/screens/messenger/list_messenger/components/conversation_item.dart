import 'package:badges/badges.dart';
import 'package:cntt2_crm/constants/enum.dart';

import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/Conversation/Conversation.dart';
import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/Label.dart';

//Components
import 'package:cntt2_crm/components/circle_avatar_with_platform.dart';

//Screens
import 'package:cntt2_crm/screens/messenger/chatbox/chatbox.screen.dart';
import 'package:provider/provider.dart';

class ConversationItem extends StatelessWidget {
  const ConversationItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conversation = Provider.of<Conversation>(context);
    return ListTile(
      leading: CircleAvatarWithPlatform(
        platform: Platform.messenger,
        radius: 30,
      ),
      title: Padding(
        padding: const EdgeInsets.all(8.0),
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
                      ? Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize:
                                Theme.of(context).textTheme.bodyText1.fontSize +
                                    2,
                          )
                      : Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize:
                                Theme.of(context).textTheme.bodyText1.fontSize +
                                    2,
                            fontWeight: FontWeight.bold,
                          ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .color
                      .withOpacity(0.5),
                  size: 14,
                ),
                Badge(
                  toAnimate: false,
                  badgeColor: Colors.blue.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  shape: BadgeShape.square,
                  badgeContent: Text(
                    AzsalesData.instance.pages.map[conversation.pageId].name,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    conversation.isReplied
                        ? 'Bạn: ' + conversation.snippet
                        : conversation.snippet,
                    style: conversation.isRead
                        ? Theme.of(context).textTheme.bodyText1
                        : Theme.of(context).textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: Layouts.SPACING / 2),
            Wrap(
                children: List.generate(conversation.labelIds.length,
                    (index) => _labelItem(conversation.labelIds[index]))),
          ],
        ),
      ),
      trailing: _moreInfo(conversation),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider.value(
            value: conversation,
            child: ChatboxScreen(),
          ),
        ),
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
        badgeColor: label.color.withOpacity(0.5),
        toAnimate: false,
        shape: BadgeShape.square,
        borderRadius: BorderRadius.circular(20),
        badgeContent: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.circle,
              color: label.color,
              size: 13,
            ),
            SizedBox(width: Layouts.SPACING / 4),
            Text(
              label.name,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _moreInfo(Conversation conversation) {
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
              Icon(Icons.phone_rounded),
              SizedBox(width: Layouts.SPACING / 4),
            ],
            if (conversation.hasNote) ...[
              Icon(Icons.note_rounded),
              SizedBox(width: Layouts.SPACING / 4),
            ],
            if (conversation.hasOrder) ...[
              Icon(Icons.shopping_cart_sharp),
              SizedBox(width: Layouts.SPACING / 4),
            ],
          ],
        ),
      ],
    );
  }
}
