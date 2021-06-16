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
                Text(
                  'Thêm \n đơn hàng',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13 ,
                  ),
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
                Text(
                  'Hóa đơn đã \n thanh toán',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13 ,
                  ),
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
                Text(
                  'Tin nhắn \n tổng hợp',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13 ,
                  ),
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
                Text(
                  'Tất cả \n hóa đơn',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13 ,

                  ),
                ),
              ],
            ),
          ]),
        ],
      ),
    );

  }
}
