import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;
import 'package:cntt2_crm/constants/icons.dart' as MyIcons;

class ShortCut  extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        children: [
          TableRow(children: [
            Column(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Image(
                    image: AssetImage(MyIcons.ADD_BILL),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                ),
                Text(
                  'Thêm \n đơn hàng',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Image(
                    image: AssetImage(MyIcons.PAY_BILL),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                ),
                Text(
                  'Hóa đơn đã \n thanh toán',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Image(
                    image: AssetImage(MyIcons.MESSAGE_ALT),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                ),
                Text(
                  'Tin nhắn \n tổng hợp',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Image(
                    image: AssetImage(MyIcons.ALL_BILL),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                ),
                Text(
                  'Tất cả \n hóa đơn',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ]),
        ],
      ),
    );

  }
}
