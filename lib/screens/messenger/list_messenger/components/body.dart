import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/enum.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Providers
import 'package:cntt2_crm/providers/azsales_api/chat_service.dart';

//Screens
import 'package:cntt2_crm/screens/messenger/chatbox/chatbox.screen.dart';

//Components
import 'package:cntt2_crm/components/circle_avatar_with_platform.dart';

//Models
import 'package:cntt2_crm/models/AzsalesData.dart';
import 'package:cntt2_crm/models/Conversation.dart';
import 'package:cntt2_crm/models/Label.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<List<Conversation>> futureConversations;

  @override
  void initState() {
    super.initState();
    final accessToken = AzsalesData.instance.azsalesAccessToken;
    futureConversations = fetchConversationsAllPages(accessToken);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Conversation>>(
          future: futureConversations,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildList(snapshot.data);
            } else if (snapshot.hasError) {
              print(snapshot.error);
            }
            return CircularProgressIndicator();
          }),
    );
  }

  Widget _buildList(List<Conversation> conversations) {
    return ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          return _buildRow(conversations[index]);
        });
  }

  Widget _buildRow(Conversation conversation) {
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
                  style: TextStyle(
                    fontWeight: conversation.isRead
                        ? FontWeight.normal
                        : FontWeight.bold,
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
                    AzsalesData.instance.pages[conversation.pageId].name,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Layouts.SPACING / 2),
            Row(
              children: [
                Expanded(
                  child: Text(
                    conversation.isReplied
                        ? 'Bạn: ' + conversation.snippet
                        : conversation.snippet +
                            'tttttttttttttttttttttttttttttttttttttttttttttttttt',
                    style: TextStyle(
                      fontWeight: conversation.isRead
                          ? FontWeight.normal
                          : FontWeight.bold,
                      color: conversation.isRead
                          ? Theme.of(context)
                              .textTheme
                              .bodyText1
                              .color
                              .withOpacity(0.5)
                          : Theme.of(context).textTheme.bodyText1.color,
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
      onTap: () => {},
    );
  }

  Widget _labelItem(String labelId) {
    Label label = AzsalesData.instance.labels[labelId];
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
        Text(conversation.updatedTime),
        SizedBox(height: Layouts.SPACING / 2),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (!conversation.hasPhone) ...[
              Icon(Icons.phone_rounded),
              SizedBox(width: Layouts.SPACING / 4),
            ],
            if (!conversation.hasNode) ...[
              Icon(Icons.note_rounded),
              SizedBox(width: Layouts.SPACING / 4),
            ],
            if (!conversation.hasOrder) ...[
              Icon(Icons.shopping_cart_sharp),
              SizedBox(width: Layouts.SPACING / 4),
            ],
          ],
        ),
      ],
    );
  }
}
