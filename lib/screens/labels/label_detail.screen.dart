import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/Label.dart';

//Components
import 'package:cntt2_crm/components/color_list.dart';

class LabelDetailScreen extends StatelessWidget {
  const LabelDetailScreen({Key key, this.label}) : super(key: key);

  final Label label;

  @override
  Widget build(BuildContext context) {
    final _title = label != null ? ' Sửa nhãn hội thoại' : 'Tạo nhãn hội thoại';
    return Scaffold(
      appBar: _addLabelScreenAppBar(context, _title),
      body: _LabelDetail(
        label: label,
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  AppBar _addLabelScreenAppBar(BuildContext context, String title) {
    return AppBar(
      title: Text(title),
    );
  }
}

class _LabelDetail extends StatefulWidget {
  const _LabelDetail({Key key, this.label}) : super(key: key);
  final Label label;
  @override
  _LabelDetailState createState() => _LabelDetailState();
}

class _LabelDetailState extends State<_LabelDetail> {
  @override
  void initState() {
    super.initState();
    if (widget.label != null) {
      _textFieldController.text = widget.label.name;
      _labelColor = widget.label.color;
    }
  }

  Color _labelColor = Colors.red;
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
                _labelName(),
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

  Widget _labelName() {
    return Row(
      children: [
        Icon(
          Icons.style_rounded,
          color: _labelColor,
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
        screenPickerColor: _labelColor,
        onColorSelected: (color) {
          setState(() {
            _labelColor = color;
          });
        },
      ),
    );
  }
}
