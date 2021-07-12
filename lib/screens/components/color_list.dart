import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class ColorList extends StatefulWidget {
  const ColorList({
    Key key,
    @required this.onColorSelected,
    this.screenPickerColor = Colors.red,
  }) : super(key: key);

  final Function(Color) onColorSelected;
  final Color screenPickerColor;
  @override
  _ColorListState createState() => _ColorListState();
}

class _ColorListState extends State<ColorList> {
  Color _screenPickerColor;

  @override
  Widget build(BuildContext context) {
    _screenPickerColor = widget.screenPickerColor;
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 2,
        child: ColorPicker(
          // Use the screenPickerColor as start color.
          color: _screenPickerColor,
          // Update the screenPickerColor using the callback.
          onColorChanged: (Color color) => setState(() {
            _screenPickerColor = color;
            widget.onColorSelected(_screenPickerColor);
          }),
          width: 44,
          height: 44,
          borderRadius: 22,
          heading: Text(
            'Chọn màu',
            style: Theme.of(context).textTheme.headline5,
          ),
          subheading: Text(
            'Chọn sắc thái',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ),
    );
  }
}
