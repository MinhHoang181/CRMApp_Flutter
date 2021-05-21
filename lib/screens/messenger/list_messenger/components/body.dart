import 'package:badges/badges.dart';
import 'package:cntt2_crm/models/Conversation.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/enum.dart';

//Models
import 'package:cntt2_crm/models/FacebookUser.dart';

//Providers
import 'package:cntt2_crm/providers/facebook_api/facebook_api.dart';

//Componetns
import 'package:cntt2_crm/components/circle_avatar_with_platform.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<Conversations> futureConversations;

  @override
  void initState() {
    super.initState();
    futureConversations = fetchConversations('102877288653109');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Conversations>(
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

  Widget _buildList(Conversations conversations) {
    return ListView.builder(
        itemCount: conversations.list.length,
        itemBuilder: (context, index) {
          return _buildRow(conversations.list[0]);
        });
  }

  Widget _buildRow(Conversation conversation) {
    final Future<FacebookUser> futureUser =
        fetchFacebookUser(conversation.userId);
    int _unreadCount = conversation.undreadCount;
    return FutureBuilder<FacebookUser>(
      future: futureUser,
      builder: (context, user) {
        if (user.hasData) {
          return ListTile(
            leading: CircleAvatarWithPlatform(
              image: user.data.urlPic,
              platform: Platform.messenger,
            ),
            title: Text(
              user.data.fullName,
              style: TextStyle(
                fontWeight:
                    _unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            subtitle: Text(
              conversation.isSender
                  ? 'Bạn: ' + conversation.snippet
                  : "" + conversation.snippet,
              style: TextStyle(
                fontWeight:
                    _unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
                color: _unreadCount > 0
                    ? Theme.of(context).textTheme.bodyText1.color
                    : Theme.of(context)
                        .textTheme
                        .bodyText1
                        .color
                        .withOpacity(0.5),
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
          );
        } else if (user.hasError) {
          print(user.error);
        }
        return Container();
      },
    );
  }
}
