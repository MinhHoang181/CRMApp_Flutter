import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//Models
import 'package:cntt2_crm/models/Cart.dart';

class TotalCostInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    int _totalQuantity = cart.getTotalQuantity();
    int _totalPrice = cart.getTotalPrice();
    int _totalDiscount = 0;
    int _feeship = 0;
    return Container(
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
              Text(
                NumberFormat('#,###').format(_totalPrice),
              ),
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
