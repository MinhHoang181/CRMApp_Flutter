import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;

class SalesInfo extends StatefulWidget {
  @override
  _SalesInfoState createState() => _SalesInfoState();
}

class _SalesInfoState extends State<SalesInfo> {
  int _moneyTotal;
  int _newOrder;
  int _cancelOrder;
  int _returnOrder;
  @override
  Widget build(BuildContext context) {
    _moneyTotal = 0;
    _newOrder = 1;
    _cancelOrder = 0;
    _returnOrder = 0;
    return Container(
      margin: EdgeInsets.all(Layouts.SPACING),
      padding: EdgeInsets.all(Layouts.SPACING),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Theme.of(context).shadowColor,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Doanh Thu Ngày',
            style: TextStyle(
              fontSize: Fonts.SIZE_TEXT_LARGE,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$_moneyTotal',
            style: TextStyle(
              fontSize: Fonts.SIZE_TEXT_LARGE * 2,
            ),
          ),
          Divider(),
          Table(
            children: [
              TableRow(children: [
                Column(
                  children: [
                    Text(
                      'Đơn mới',
                      style: TextStyle(
                        fontSize: Fonts.SIZE_TEXT_MEDIUM,
                      ),
                    ),
                    Text(
                      '$_newOrder',
                      style: TextStyle(
                        fontSize: Fonts.SIZE_TEXT_MEDIUM * 1.5,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Đơn hủy',
                      style: TextStyle(
                        fontSize: Fonts.SIZE_TEXT_MEDIUM,
                      ),
                    ),
                    Text(
                      '$_cancelOrder',
                      style: TextStyle(
                        fontSize: Fonts.SIZE_TEXT_MEDIUM * 1.5,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Đơn trả về',
                      style: TextStyle(
                        fontSize: Fonts.SIZE_TEXT_MEDIUM,
                      ),
                    ),
                    Text(
                      '$_returnOrder',
                      style: TextStyle(
                        fontSize: Fonts.SIZE_TEXT_MEDIUM * 1.5,
                      ),
                    ),
                  ],
                ),
              ]),
            ],
          )
        ],
      ),
    );
  }
}
