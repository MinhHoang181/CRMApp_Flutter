import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/Order/DailyOrderInfo.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SalesInfo extends StatefulWidget {
  const SalesInfo({Key key}) : super(key: key);

  @override
  _SalesInfoState createState() => _SalesInfoState();
}

class _SalesInfoState extends State<SalesInfo> {
  final int _cancelOrder = 0;
  final int _returnOrder = 0;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading ? _loading() : _futureBuilder();
  }

  Widget _futureBuilder() {
    return FutureBuilder<DailyOrderInfo>(
      future: AzsalesData.instance.dailyOrderInfo.fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _infoTable(context, snapshot.data);
        } else if (snapshot.hasError) {
          print(snapshot.error.toString());
        }
        return _loading();
      },
    );
  }

  Widget _loading() {
    return Container(
      height: 160,
      margin: EdgeInsets.all(Layouts.SPACING),
      padding: EdgeInsets.all(Layouts.SPACING),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            offset: Offset(0, 2),
            color: Theme.of(context).shadowColor,
          ),
        ],
      ),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _infoTable(BuildContext context, DailyOrderInfo dailyOrderInfo) {
    return Stack(
      children: [
        _salesInfo(dailyOrderInfo),
        _refreshButton(dailyOrderInfo),
      ],
    );
  }

  Widget _salesInfo(DailyOrderInfo dailyOrderInfo) {
    return Container(
      margin: EdgeInsets.all(Layouts.SPACING),
      padding: EdgeInsets.all(Layouts.SPACING),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            offset: Offset(0, 2),
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
            NumberFormat('#,### đ').format(dailyOrderInfo.amount),
            style: GoogleFonts.robotoMono(
              textStyle: TextStyle(fontSize: 35, fontWeight: FontWeight.normal),
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
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${dailyOrderInfo.newOrder}',
                      style: GoogleFonts.robotoMono(
                        textStyle:
                            TextStyle(fontSize: Fonts.SIZE_TEXT_MEDIUM * 1.5),
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
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$_cancelOrder',
                      style: GoogleFonts.robotoMono(
                        textStyle:
                            TextStyle(fontSize: Fonts.SIZE_TEXT_MEDIUM * 1.5),
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
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${dailyOrderInfo.returnOrder}',
                      style: GoogleFonts.robotoMono(
                        textStyle:
                            TextStyle(fontSize: Fonts.SIZE_TEXT_MEDIUM * 1.5),
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

  Widget _refreshButton(DailyOrderInfo dailyOrderInfo) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: const EdgeInsets.only(
          top: Layouts.SPACING / 2,
          right: Layouts.SPACING / 2,
        ),
        child: IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              _isLoading = true;
              _refresh(dailyOrderInfo);
            });
          },
        ),
      ),
    );
  }

  void _refresh(DailyOrderInfo dailyOrderInfo) async {
    await dailyOrderInfo.refreshData();
    setState(() {
      _isLoading = false;
    });
  }
}
