import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/icons.dart' as MyIcons;

class DarkModeSwitch extends StatefulWidget {
  const DarkModeSwitch({Key key}) : super(key: key);

  @override
  _DarkModeSwitchState createState() => _DarkModeSwitchState();
}

class _DarkModeSwitchState extends State<DarkModeSwitch> {
  bool _light = true;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding:  const EdgeInsets.only(
            left: Layouts.SPACING,
            top: Layouts.SPACING,
            bottom:  Layouts.SPACING/2
        ),
        child: Row(
          children: [
            SizedBox(
              width: 45,
              height: 45,
              child: Image(
                image: AssetImage(MyIcons.DARK),
              ),
            ),
            SizedBox(width: Layouts.SPACING),
            Text('Chế độ tối',style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w600,fontSize: 16)),
            Spacer(),
            Switch(value: _light,onChanged: (state){
              setState(() {
                _light = state;
              });
            })
          ],
        ),
      ),
    );
  }
}
