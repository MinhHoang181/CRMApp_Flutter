import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/QuickReply.dart';

class ReplyDetailScreen extends StatefulWidget {
  const ReplyDetailScreen({Key key, this.reply}) : super(key: key);

  final QuickReply reply;

  @override
  _ReplyDetailScreenState createState() => _ReplyDetailScreenState();
}

class _ReplyDetailScreenState extends State<ReplyDetailScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.reply != null) {
      _shortcut.text = widget.reply.shortcut;
      _text.text = widget.reply.text;
      _title = 'Sửa câu trả lời';
    } else {
      _title = 'Tạo câu trả lời';
    }
  }

  TextEditingController _shortcut = new TextEditingController();
  TextEditingController _text = new TextEditingController();
  String _title = '';
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
              color: _shortcut.text.isNotEmpty && _text.text.isNotEmpty
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
            ),
          ),
          onPressed: _shortcut.text.isNotEmpty && _text.text.isNotEmpty
              ? () => _onPressSaveButton(_shortcut.text, _text.text)
              : null,
        ),
      ],
    );
  }

  void _onPressSaveButton(String shortcut, String text) {
    Navigator.pop(context);
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
              setState(() {});
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
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
