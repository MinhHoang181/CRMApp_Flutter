import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;

//Model
import 'package:cntt2_crm/models/Tag.dart';

class TagItem extends StatelessWidget {
  const TagItem({Key key, @required this.tag}) : super(key: key);

  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Layouts.SPACING),
      child: Row(
        children: [
          Icon(
            Icons.style_rounded,
            color: tag.color,
          ),
          SizedBox(
            width: Layouts.SPACING,
          ),
          Text(
            tag.name,
            style: TextStyle(
              fontSize: Fonts.SIZE_ITEM_LIST,
            ),
          ),
        ],
      ),
    );
  }
}
