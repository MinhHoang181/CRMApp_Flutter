import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;
import 'package:cntt2_crm/constants/enum.dart';
import 'package:provider/provider.dart';

//screen
import 'package:cntt2_crm/screens/labels/select_label.screen.dart';
import 'package:cntt2_crm/screens/orders/add_order/add_order.screen.dart';
import 'package:cntt2_crm/screens/messenger/conversation_info/conversation_info.screen.dart';

//components
import 'package:cntt2_crm/components/circle_avatar_with_platform.dart';
import 'components/chatbox.dart';

//Models
import 'package:cntt2_crm/models/Cart.dart';
import 'package:cntt2_crm/models/Conversation/Conversation.dart';
import 'package:cntt2_crm/models/list_model/MessageList.dart';
import 'package:cntt2_crm/models/list_model/CustomerList.dart';

class ChatboxScreen extends StatelessWidget {
  const ChatboxScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conversation = Provider.of<Conversation>(context, listen: false);
    return Scaffold(
      appBar: _chatboxScreenAppBar(context),
      body: FutureBuilder<MessageList>(
        future: conversation.messages.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChangeNotifierProvider<MessageList>.value(
              value: snapshot.data,
              child: ChatBox(),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  AppBar _chatboxScreenAppBar(BuildContext context) {
    final conversation = Provider.of<Conversation>(context, listen: false);
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
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider.value(
              value: conversation,
              child: ConversationInfoScreen(),
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
