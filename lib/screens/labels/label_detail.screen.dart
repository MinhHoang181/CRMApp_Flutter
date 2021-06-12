import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/utilities/text_color.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:future_button/future_button.dart';

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

  bool _canSave = false;
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
            _futureSaveButton(),
          ],
        ),
      ),
    );
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
              setState(() {
                _checkCanSave();
              });
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
            _checkCanSave();
          });
        },
      ),
    );
  }

  void _checkCanSave() {
    bool check1, check2;
    if (widget.label == null) {
      check1 = _textFieldController.text.isNotEmpty;
      _canSave = check1;
    } else {
      check1 = _textFieldController.text.isNotEmpty &&
          _textFieldController.text != widget.label.name;
      check2 = _labelColor != widget.label.color;
      _canSave = check1 || check2;
    }
  }

  Future _onPressSaveButton() async {
    bool check;
    if (widget.label == null) {
      check = await AzsalesData.instance
          .createLabel(_textFieldController.text, colorToString(_labelColor));
    } else {
      check = await AzsalesData.instance.updateLabel(widget.label.id,
          _textFieldController.text, colorToString(_labelColor));
    }
    if (check) {
      Navigator.pop(context);
    } else {
      throw Exception();
    }
  }

  Widget _futureSaveButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        child: FutureCupertinoButton.filled(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.save_alt_rounded,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              SizedBox(width: Layouts.SPACING),
              Text(
                'Lưu',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
          onPressed: _canSave ? _onPressSaveButton : null,
        ),
      ),
    );
  }
}
