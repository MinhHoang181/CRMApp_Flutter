import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;
import 'package:cntt2_crm/constants/enum.dart';
import 'package:provider/provider.dart';

//screen
import 'package:cntt2_crm/screens/labels/select_label.screen.dart';
import 'package:cntt2_crm/screens/orders/add_order/add_order.screen.dart';
//components
import 'components/body.dart';
import 'package:cntt2_crm/components/circle_avatar_with_platform.dart';
//Models
import 'package:cntt2_crm/models/Cart.dart';
import 'package:cntt2_crm/models/Conversation.dart';
import 'package:cntt2_crm/models/list_model/MessageList.dart';

class ChatboxScreen extends StatelessWidget {
  final Conversation conversation;

  const ChatboxScreen({Key key, @required this.conversation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _chatboxScreenAppBar(context),
      body: Center(
        child: FutureBuilder<MessageList>(
            future: conversation.messages.fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ChangeNotifierProvider<MessageList>.value(
                  value: snapshot.data,
                  child: Body(),
                );
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
              conversation.participants[0].name,
              style: TextStyle(fontSize: Fonts.SIZE_TEXT_MEDIUM),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        onTap: () => {},
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.style_rounded),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider.value(
                value: conversation,
                child: SelectLabelScreen(),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add_shopping_cart_rounded),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => Cart(),
                child: AddOrderScreen(),
              ),
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
