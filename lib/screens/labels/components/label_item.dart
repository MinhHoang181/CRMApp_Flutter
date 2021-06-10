import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;

//Model
import 'package:cntt2_crm/models/Label.dart';

class LabelItem extends StatelessWidget {
  const LabelItem({Key key, @required this.label}) : super(key: key);

  final Label label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Layouts.SPACING),
      child: Row(
        children: [
          Icon(
            Icons.style_rounded,
            color: label.color,
          ),
          SizedBox(
            width: Layouts.SPACING,
          ),
          Text(
            label.name,
            style: TextStyle(
              fontSize: Fonts.SIZE_ITEM_LIST,
            ),
          ),
        ],
      ),
    );
  }
}
