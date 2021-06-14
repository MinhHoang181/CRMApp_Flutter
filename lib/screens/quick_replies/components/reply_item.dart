import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

//Models
import 'package:cntt2_crm/models/QuickReply.dart';
import 'package:provider/provider.dart';

//Screen
import '../reply_detail.screen.dart';

class ReplyItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reply = Provider.of<QuickReply>(context);
    return Slidable(
      key: ValueKey(reply.shortcut),
      actionPane: SlidableScrollActionPane(),
      child: ListTile(
        title: Text(
          reply.shortcut,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          reply.text,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.5),
          ),
        ),
        onTap: () => Navigator.pop(context, reply.text),
      ),
      secondaryActions: [
        IconSlideAction(
          icon: Icons.edit_rounded,
          caption: 'Sửa',
          color: Theme.of(context).colorScheme.onBackground,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReplyDetailScreen(reply: reply),
            ),
          ),
        ),
        IconSlideAction(
          icon: Icons.delete_rounded,
          caption: 'Xoá',
          color: Theme.of(context).colorScheme.onBackground,
          onTap: () => {},
        ),
      ],
    );
  }
}
