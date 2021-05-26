import 'package:badges/badges.dart';
import 'package:cntt2_crm/models/Conversation.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/enum.dart';

//Providers
import 'package:cntt2_crm/providers/facebook_api/facebook_api.dart';

//Screens
import 'package:cntt2_crm/screens/messenger/chatbox/chatbox.screen.dart';

//Components
import 'package:cntt2_crm/components/circle_avatar_with_platform.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<ConversationModel> futureConversations;

  @override
  void initState() {
    super.initState();
    futureConversations = fetchConversations('102877288653109');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<ConversationModel>(
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

  Widget _buildList(ConversationModel conversations) {
    return ListView.builder(
        itemCount: conversations.all.length,
        itemBuilder: (context, index) {
          return _buildRow(conversations.all[index]);
        });
  }

  Widget _buildRow(Conversation conversation) {
    int _unreadCount = conversation.undreadCount;
    return ListTile(
      leading: CircleAvatarWithPlatform(
        platform: Platform.messenger,
      ),
      title: Text(
        conversation.users[0].name,
        style: TextStyle(
          fontWeight: _unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        conversation.isSender
            ? 'Bạn: ' + conversation.snippet
            : "" + conversation.snippet,
        style: TextStyle(
          fontWeight: _unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
          color: _unreadCount > 0
              ? Theme.of(context).textTheme.bodyText1.color
              : Theme.of(context).textTheme.bodyText1.color.withOpacity(0.5),
        ),
      ),
      trailing: Badge(
        showBadge: _unreadCount > 0 ? true : false,
        padding: EdgeInsets.all(Layouts.SPACING / 2),
        badgeContent: Text(
          '$_unreadCount',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatboxScreen(
            conversationId: conversation.id,
            customerId: conversation.users[0].id,
            customerName: conversation.users[0].name,
          ),
        ),
      ),
    );
  }
}
