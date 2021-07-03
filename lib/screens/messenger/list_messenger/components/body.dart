import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Models
import 'package:cntt2_crm/models/Conversation/Conversations.dart';
import 'package:cntt2_crm/models/Conversation/FilterConversation.dart';

//Components
import 'list_conversation.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    final Conversations conversations = context.watch<Conversations>();
    final filter = context.watch<FilterConversation>();
    return FutureBuilder<Conversations>(
      future: conversations.fetchData(filter),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ChangeNotifierProvider<Conversations>.value(
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
