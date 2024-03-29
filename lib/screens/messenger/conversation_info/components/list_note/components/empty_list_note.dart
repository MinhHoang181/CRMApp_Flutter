import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/images.dart' as MyImages;
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

class EmptyListNote extends StatelessWidget {
  const EmptyListNote({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.onBackground,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(Layouts.SPACING * 2),
          child: Image.asset(
            MyImages.EMPTY_NOTE,
          ),
        ),
      ),
    );
  }
}
