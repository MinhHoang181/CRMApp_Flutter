import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

class TotalCostInfo extends StatefulWidget {
  @override
  _TotalCostInfoState createState() => _TotalCostInfoState();
}

class _TotalCostInfoState extends State<TotalCostInfo> {
  int _totalQuantity = 0;
  int _totalCost = 0;
  int _totalDiscount = 0;
  int _feeship = 0;
  @override
  Widget build(BuildContext context) {
    _totalQuantity = 0;
    _totalCost = 0;
    _totalDiscount = 0;
    _feeship = 0;
    return Container(
      margin: EdgeInsets.symmetric(vertical: Layouts.SPACING / 2),
      padding: EdgeInsets.all(Layouts.SPACING),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Tổng số lượng',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text('$_totalQuantity'),
            ],
          ),
          SizedBox(height: Layouts.SPACING),
          Row(
            children: [
              Text(
                'Tổng tiền hàng',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text('$_totalCost'),
            ],
          ),
          SizedBox(height: Layouts.SPACING),
          Row(
            children: [
              Text(
                'Tổng chiết khấu',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                ),
              ),
              Spacer(),
              Text('$_totalDiscount'),
            ],
          ),
          SizedBox(height: Layouts.SPACING),
          Row(
            children: [
              Text(
                'Phí giao hàng',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                ),
              ),
              Spacer(),
              Text('$_feeship'),
            ],
          ),
        ],
      ),
    );
  }
}
