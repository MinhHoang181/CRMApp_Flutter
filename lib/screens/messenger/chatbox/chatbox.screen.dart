import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;
import 'package:cntt2_crm/constants/enum.dart';

//screen
import 'package:cntt2_crm/screens/tags/select_tag.screen.dart';
import 'package:cntt2_crm/screens/customers/profile_customer/profile_customer.screen.dart';
import 'package:cntt2_crm/screens/orders/add_order/add_order.screen.dart';
//components
import 'components/body.dart';
import 'package:cntt2_crm/components/circle_avatar_with_platform.dart';
//Models
import 'package:cntt2_crm/models/ChatMessage.dart';
//Providers
import 'package:cntt2_crm/providers/facebook_api/facebook_api.dart';

class ChatboxScreen extends StatelessWidget {
  final String conversationId;
  final String customerId;
  final String customerName;

  const ChatboxScreen({
    Key key,
    @required this.conversationId,
    @required this.customerId,
    @required this.customerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<ChatMessage>> futureListChatMessage =
        fetchConversation(conversationId);
    return Scaffold(
      appBar: _chatboxScreenAppBar(context),
      body: Center(
        child: FutureBuilder<List<ChatMessage>>(
            future: futureListChatMessage,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Body(chatlog: snapshot.data);
              } else if (snapshot.hasError) {
                print(snapshot.error);
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }

  AppBar _chatboxScreenAppBar(BuildContext context) {
    return AppBar(
      title: InkWell(
        child: Row(
          children: [
            CircleAvatarWithPlatform(
              radius: 22,
              platform: Platform.messenger,
              isActive: true,
            ),
            SizedBox(
              width: Layouts.SPACING * 0.75,
            ),
            Text(
              customerName,
              style: TextStyle(fontSize: Fonts.SIZE_TEXT_MEDIUM),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileCustomerScreen(
              customerId: customerId,
              customerName: customerName,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.style_rounded),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectTagScreen(),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add_shopping_cart_rounded),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddOrderScreen(),
            ),
          ),
        ),
        SizedBox(
          width: Layouts.SPACING / 2,
        )
      ],
    );
  }
}
