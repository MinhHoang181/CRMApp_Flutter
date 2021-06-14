import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Models
import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/list_model/ConversationList.dart';

//Components
import 'package:cntt2_crm/screens/messenger/list_messenger/components/conversation_list.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return FutureBuilder<ConversationList>(
      future: AzsalesData.instance.conversations.fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ChangeNotifierProvider<ConversationList>.value(
            value: snapshot.data,
            child: ListConversation(),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
