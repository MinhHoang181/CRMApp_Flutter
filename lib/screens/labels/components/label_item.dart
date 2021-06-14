import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;

//Model
import 'package:cntt2_crm/models/Label.dart';
import 'package:provider/provider.dart';

class LabelItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final label = Provider.of<Label>(context);
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
