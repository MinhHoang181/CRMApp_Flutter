import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/Tag.dart';

//Components
import 'package:cntt2_crm/components/color_list.dart';

class TagDetailScreen extends StatelessWidget {
  const TagDetailScreen({Key key, this.tag}) : super(key: key);

  final Tag tag;

  @override
  Widget build(BuildContext context) {
    final _title = tag != null ? ' Sửa nhãn hội thoại' : 'Tạo nhãn hội thoại';
    return Scaffold(
      appBar: _addTagScreenAppBar(context, _title),
      body: _TagDetail(
        tag: tag,
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  AppBar _addTagScreenAppBar(BuildContext context, String title) {
    return AppBar(
      title: Text(title),
    );
  }
}

class _TagDetail extends StatefulWidget {
  const _TagDetail({Key key, this.tag}) : super(key: key);
  final Tag tag;
  @override
  _TagDetailState createState() => _TagDetailState();
}

class _TagDetailState extends State<_TagDetail> {
  @override
  void initState() {
    super.initState();
    if (widget.tag != null) {
      _textFieldController.text = widget.tag.name;
      _tagColor = widget.tag.color;
    }
  }

  Color _tagColor = Colors.red;
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(Layouts.SPACING),
        child: Stack(
          children: [
            Column(
              children: [
                _tagName(),
                SizedBox(
                  height: Layouts.SPACING,
                ),
                _colorTable(),
              ],
            ),
            _saveButton(context),
          ],
        ),
      ),
    );
  }

  Widget _saveButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          icon: Icon(Icons.save_alt_rounded),
          label: Text('Lưu'),
          style: ElevatedButton.styleFrom(
            primary: _textFieldController.text.isNotEmpty
                ? Theme.of(context).primaryColor
                : Colors.grey,
          ),
          onPressed: () => _textFieldController.text.isNotEmpty
              ? _onPressSaveButton(context)
              : null,
        ),
      ),
    );
  }

  void _onPressSaveButton(BuildContext context) {
    Navigator.pop(context);
  }

  Widget _tagName() {
    return Row(
      children: [
        Icon(
          Icons.style_rounded,
          color: _tagColor,
          size: 60,
        ),
        SizedBox(width: Layouts.SPACING),
        Expanded(
          child: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              hintText: 'Nhập tên nhãn',
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _colorTable() {
    return Container(
      child: ColorList(
        screenPickerColor: _tagColor,
        onColorSelected: (color) {
          setState(() {
            _tagColor = color;
          });
        },
      ),
    );
  }
}
