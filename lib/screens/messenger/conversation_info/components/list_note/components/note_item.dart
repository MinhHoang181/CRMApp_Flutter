import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

//Models
import 'package:cntt2_crm/models/Note.dart';

//Components
import 'package:cntt2_crm/components/progress_dialog.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final note = Provider.of<Note>(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 100,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Layouts.SPACING / 2,
        ),
        child: Card(
          elevation: 3,
          child: Slidable(
            key: ValueKey(note.id),
            actionPane: SlidableScrollActionPane(),
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
                      Text(
                        note.dateUpdate == null
                            ? note.dateCreate
                            : note.dateUpdate,
                      ),
                      SizedBox(height: Layouts.SPACING / 2),
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
                    ],
                  ),
                ],
              ),
            ),
            secondaryActions: [
              IconSlideAction(
                icon: Icons.edit_rounded,
                caption: 'Sửa',
                color: Colors.yellow,
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => _EditDialog(note: note),
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
        ),
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

class _EditDialog extends StatefulWidget {
  final Note note;
  const _EditDialog({Key key, @required this.note}) : super(key: key);

  @override
  __EditDialogState createState() => __EditDialogState();
}

class __EditDialogState extends State<_EditDialog> {
  final _controller = TextEditingController();
  bool _canSave = false;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.note.text;
  }

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Sửa nội dung ghi chú',
        style: TextStyle(
          fontSize: 14,
        ),
      ),
      content: TextField(
        controller: _controller,
        minLines: 1,
        maxLines: 3,
        decoration: InputDecoration(
          filled: false,
          border: UnderlineInputBorder(),
        ),
        onChanged: (value) => setState(() {
          _checkCanSave(value);
        }),
      ),
      actions: [
        TextButton(
          child: Text('Hủy'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Lưu'),
          onPressed: _canSave
              ? () {
                  Navigator.of(context).pop(_controller.text);
                }
              : null,
        )
      ],
    );
  }

  bool _checkCanSave(String text) {
    return _canSave = text.isNotEmpty && text != widget.note.text;
  }
}
