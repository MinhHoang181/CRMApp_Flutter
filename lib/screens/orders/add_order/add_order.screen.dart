import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//Components
import 'components/body.dart';

//Models
import 'package:cntt2_crm/models/Cart.dart';

class AddOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _addOrderScreenAppBar(context),
      body: Body(),
      bottomNavigationBar: _createOrderButton(context),
    );
  }

  AppBar _addOrderScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Thêm đơn hàng'),
    );
  }

  BottomAppBar _createOrderButton(BuildContext context) {
    return BottomAppBar(
      child: Container(
        padding: EdgeInsets.all(Layouts.SPACING),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).shadowColor,
                offset: Offset(0, -2),
                blurRadius: 2),
          ],
        ),
        child: Table(
          children: [
            TableRow(
              children: [
                Row(
                  children: [
                    Text(
                      'Tạm tính',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Fonts.SIZE_TEXT_LARGE,
                      ),
                    ),
                    Spacer(),
                    Text(
                      NumberFormat('#,###')
                          .format(Provider.of<Cart>(context).getTotalCost()),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Fonts.SIZE_TEXT_LARGE,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            TableRow(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text('Tạo đơn hàng'),
                        onPressed: () => {},
                      ),
                    ),
                    SizedBox(width: Layouts.SPACING),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white.withOpacity(0.6),
                      ),
                      child: Icon(
                        Icons.more_horiz_rounded,
                        color: Colors.black,
                      ),
                      onPressed: () => {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
