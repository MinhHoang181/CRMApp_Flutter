import 'package:flutter/material.dart';

//test
import 'package:cntt2_crm/screens/messenger/chatbox/chatbox.screen.dart';
import 'package:cntt2_crm/screens/tags/tags.screen.dart';
import 'package:cntt2_crm/screens/quick_answers/answers.screen.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _moreScreenAppBar(context),
      body: Center(
        child: Column(
          children: [
            IconButton(
              icon: Icon(Icons.message_rounded),
              iconSize: 100,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnswersScreen(),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.style_rounded),
              iconSize: 100,
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TagsScreen(),
                  )),
            ),
            SizedBox(
              height: 50,
            ),
            IconButton(
              icon: Icon(Icons.messenger),
              iconSize: 100,
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatboxScreen(),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _moreScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('More'),
    );
  }
}
