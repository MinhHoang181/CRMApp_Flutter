import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/QuickReply.dart';

//Components
import 'package:cntt2_crm/components/progress_dialog.dart';

class ReplyDetailScreen extends StatefulWidget {
  final QuickReply reply;
  const ReplyDetailScreen({Key key, this.reply}) : super(key: key);

  @override
  _ReplyDetailScreenState createState() => _ReplyDetailScreenState();
}

class _ReplyDetailScreenState extends State<ReplyDetailScreen> {
  TextEditingController _shortcut = new TextEditingController();
  TextEditingController _text = new TextEditingController();
  String _title = '';
  bool _canSave = false;

  @override
  void initState() {
    if (!mounted) return;
    super.initState();
    if (widget.reply != null) {
      _shortcut.text = widget.reply.shortcut;
      _text.text = widget.reply.text;
      _title = 'Sửa câu trả lời';
    } else {
      _title = 'Tạo câu trả lời';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _addReplyScreenAppBar(context),
      body: _bodyReplyDetail(),
    );
  }

  AppBar _addReplyScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text(_title),
      actions: [
        TextButton(
          child: Text(
            'Lưu',
            style: TextStyle(
              color: _canSave
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
            ),
          ),
          onPressed: _canSave
              ? () => showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => ProgressDialog(
                      future: _onPressSaveButton(_shortcut.text, _text.text),
                      loading: widget.reply == null
                          ? 'Đang tạo tin nhắn mẫu'
                          : 'Đang cập nhật',
                      success: widget.reply == null
                          ? 'Tạo tin nhắn mẫu thành công'
                          : 'Cập nhật thành công',
                      falied: widget.reply == null
                          ? 'Tạo tin nhắn mẫu thất bại'
                          : 'Cập nhật thất bại',
                    ),
                  ).then(
                    (value) => value ? Navigator.of(context).pop() : null,
                  )
              : null,
        ),
      ],
    );
  }

  Future<bool> _onPressSaveButton(String shortcut, String text) async {
    if (widget.reply == null) {
      return await AzsalesData.instance.replies.createReply(shortcut, text);
    } else {
      return await widget.reply.update(shortcut, text);
    }
  }

  Widget _bodyReplyDetail() {
    return Container(
      margin: EdgeInsets.all(Layouts.SPACING),
      child: Column(
        children: [
          _shortcutLabel(),
          SizedBox(
            height: Layouts.SPACING * 2,
          ),
          _textLabel(),
        ],
      ),
    );
  }

  Widget _shortcutLabel() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tiêu đề',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: Layouts.SPACING,
          ),
          TextField(
            controller: _shortcut,
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nhập nội dung tiêu đề...',
              fillColor: Theme.of(context).colorScheme.onBackground,
            ),
            onChanged: (value) {
              if (_canSave != _checkCanSave())
                setState(() {
                  _canSave = _checkCanSave();
                });
            },
          ),
        ],
      ),
    );
  }

  Widget _textLabel() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Văn bản',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: Layouts.SPACING,
          ),
          TextField(
            controller: _text,
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nhập nội dung câu trả lời...',
              fillColor: Theme.of(context).colorScheme.onBackground,
            ),
            onChanged: (value) {
              if (_canSave != _checkCanSave())
                setState(() {
                  _canSave = _checkCanSave();
                });
            },
          ),
        ],
      ),
    );
  }

  bool _checkCanSave() {
    if (widget.reply == null) {
      return _shortcut.text.isNotEmpty && _text.text.isNotEmpty;
    } else {
      bool check1 = _shortcut.text != widget.reply.shortcut;
      bool check2 = _text.text != widget.reply.text;
      return _shortcut.text.isNotEmpty &&
          _text.text.isNotEmpty &&
          (check1 || check2);
    }
  }
}
