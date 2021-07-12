import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

//Models
import 'package:cntt2_crm/models/Note.dart';

//Components
import 'package:cntt2_crm/screens/components/progress_dialog.dart';
import 'package:cntt2_crm/screens/messenger/conversation_info/components/edit_dialog.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final note = Provider.of<Note>(context);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Layouts.SPACING / 2,
      ),
      child: Slidable(
        key: ValueKey(note.id),
        actionPane: SlidableScrollActionPane(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 100,
          ),
          child: Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(Layouts.SPACING / 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      note.text,
                    ),
                  ),
                  SizedBox(width: Layouts.SPACING),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (note.dateUpdate != null) ...[
                        Text(
                          'Cập nhật: ' + note.dateUpdate,
                        ),
                        SizedBox(height: Layouts.SPACING),
                      ],
                      Text(
                        note.createBy,
                        style: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .color
                              .withOpacity(0.7),
                        ),
                      ),
                      Text(
                        'Tạo: ' + note.dateCreate,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        secondaryActions: [
          IconSlideAction(
            icon: Icons.edit_rounded,
            caption: 'Sửa',
            color: Colors.yellow,
            onTap: () => showDialog(
              context: context,
              builder: (context) => EditDialog(note: note),
            ).then(
              (value) => value != null
                  ? _showUpdateProgress(context, note, value)
                  : null,
            ),
          ),
          IconSlideAction(
            icon: Icons.delete_rounded,
            caption: 'Xoá',
            color: Colors.red,
            onTap: () => {},
          ),
        ],
      ),
    );
  }

  Future _showUpdateProgress(BuildContext context, Note note, String text) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => ProgressDialog(
        future: note.update(text),
        loading: 'Đang cập nhật ghi chú',
        success: 'Cập nhật ghi chú thành công',
        falied: 'Cập nhật ghi chú thất bại',
      ),
    );
  }
}
