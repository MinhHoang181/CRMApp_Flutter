import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Components
import 'components/reply_item.dart';

//Models
import 'package:cntt2_crm/models/QuickReply.dart';

//Screens
import 'reply_detail.screen.dart';

class RepliesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _answersScreenAppBar(context),
      body: Container(
        margin: EdgeInsets.only(top: Layouts.SPACING),
        child: _ListReply(),
      ),
    );
  }

  AppBar _answersScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Tin trả lời lưu sẵn'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReplyDetailScreen(),
            ),
          ),
        ),
      ],
    );
  }
}

class _ListReply extends StatefulWidget {
  @override
  __ListReplyState createState() => __ListReplyState();
}

class __ListReplyState extends State<_ListReply> {
  @override
  Widget build(BuildContext context) {
    final replies = AzsalesData.instance.replies;
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      itemCount: replies.length,
      itemBuilder: (context, index) =>
          _buildRow(replies.values.elementAt(index)),
    );
  }

  Widget _buildRow(QuickReply reply) {
    return ReplyItem(reply: reply);
  }
}
