import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

//Models
import 'package:cntt2_crm/models/QuickAnswer.dart';

//Screen
import '../answer_detail.screen.dart';

class AnswerItem extends StatefulWidget {
  const AnswerItem({Key key, @required this.answer}) : super(key: key);

  final QuickAnswer answer;

  @override
  _AnswerItemState createState() => _AnswerItemState();
}

class _AnswerItemState extends State<AnswerItem> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(widget.answer.shortcut),
      actionPane: SlidableScrollActionPane(),
      child: ListTile(
        title: Text(
          widget.answer.shortcut,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          widget.answer.text,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.5),
          ),
        ),
        onTap: () => Navigator.pop(context, widget.answer.text),
      ),
      secondaryActions: [
        IconSlideAction(
          icon: Icons.edit_rounded,
          caption: 'Sửa',
          color: Theme.of(context).colorScheme.onBackground,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnswerDetailScreen(
                answer: widget.answer,
              ),
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
