import 'package:cntt2_crm/components/progress_dialog.dart';
import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/utilities/text_color.dart';
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

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
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
            //_futureSaveButton(),
            _saveButton(),
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

  Future<bool> _onPressSaveButton() async {
    bool check;
    if (widget.label == null) {
      check = await AzsalesData.instance.labels
          .createLabel(_textFieldController.text, colorToString(_labelColor));
    } else {
      check = await widget.label
          .update(_textFieldController.text, colorToString(_labelColor));
    }
    if (!mounted) return false;
    if (check) {
      return true;
    }
    return false;
  }

  Widget _saveButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
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
          onPressed: _canSave
              ? () => showDialog<bool>(
                    context: context,
                    builder: (context) => ProgressDialog(
                      loading: widget.label == null
                          ? 'Đang tạo nhãn'
                          : 'Đang cập nhật',
                      success: widget.label == null
                          ? 'Tạo thành nhãn công'
                          : 'Cập nhật thành công',
                      falied: widget.label == null
                          ? 'Tạo nhãn thất bại'
                          : 'Cập nhật thất bại',
                      future: _onPressSaveButton(),
                    ),
                    barrierDismissible: false,
                  ).then(
                    (value) => value ? Navigator.of(context).pop() : null,
                  )
              : null,
        ),
      ),
    );
  }
}
