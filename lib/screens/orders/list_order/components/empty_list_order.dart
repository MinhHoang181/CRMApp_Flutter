import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/images.dart' as MyImages;
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

class EmptyListOrder extends StatelessWidget {
  const EmptyListOrder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(Layouts.SPACING * 2),
          child: Image.asset(
            MyImages.EMPTY_ORDER,
          ),
        ),
      ),
    );
  }
}
