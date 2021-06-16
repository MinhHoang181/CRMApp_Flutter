import 'package:flutter/material.dart';

//Models
import 'package:cntt2_crm/models/Note.dart';

class EditDialog extends StatefulWidget {
  final Note note;
  const EditDialog({Key key, this.note}) : super(key: key);

  @override
  _EditDialogState createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  final _controller = TextEditingController();
  bool _canSave = false;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) _controller.text = widget.note.text;
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
        widget.note != null ? 'Sửa nội dung ghi chú' : 'Tạo ghi chú',
        style: TextStyle(
          fontSize: 14,
        ),
      ),
      content: TextField(
        controller: _controller,
        minLines: 1,
        maxLines: 3,
        autofocus: true,
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
    if (widget.note == null) return _canSave = text.isNotEmpty;
    return _canSave = text.isNotEmpty && text != widget.note.text;
  }
}
