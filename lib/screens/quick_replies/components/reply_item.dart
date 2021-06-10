import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

//Models
import 'package:cntt2_crm/models/QuickReply.dart';

//Screen
import '../reply_detail.screen.dart';

class ReplyItem extends StatefulWidget {
  const ReplyItem({Key key, @required this.reply}) : super(key: key);

  final QuickReply reply;

  @override
  _ReplyItemState createState() => _ReplyItemState();
}

class _ReplyItemState extends State<ReplyItem> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(widget.reply.shortcut),
      actionPane: SlidableScrollActionPane(),
      child: ListTile(
        title: Text(
          widget.reply.shortcut,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          widget.reply.text,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.5),
          ),
        ),
        onTap: () => Navigator.pop(context, widget.reply.text),
      ),
      secondaryActions: [
        IconSlideAction(
          icon: Icons.edit_rounded,
          caption: 'Sửa',
          color: Theme.of(context).colorScheme.onBackground,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReplyDetailScreen(reply: widget.reply),
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
