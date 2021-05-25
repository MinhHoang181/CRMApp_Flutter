import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Layouts.SPACING / 2),
      padding: EdgeInsets.symmetric(
        vertical: Layouts.SPACING / 2,
        horizontal: Layouts.SPACING,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          'Thêm ghi chú',
          style: TextStyle(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
          ),
        ),
        trailing: Icon(
          Icons.edit_rounded,
          color: Theme.of(context).primaryColor.withOpacity(0.7),
        ),
      ),
    );
  }
}
