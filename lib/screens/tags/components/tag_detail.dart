import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/Tag.dart';

//Components
import 'package:cntt2_crm/components/color_list.dart';

class TagDetail extends StatefulWidget {
  const TagDetail({Key key, this.tag}) : super(key: key);
  final Tag tag;
  @override
  _TagDetailState createState() => _TagDetailState();
}

class _TagDetailState extends State<TagDetail> {
  Color _tagColor = Colors.red;
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.tag != null) {
      _textFieldController.text = widget.tag.name;
      _tagColor = widget.tag.color;
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          _tagName(),
          SizedBox(
            height: Layouts.SPACING,
          ),
          _colorTable(),
        ],
      ),
    );
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
