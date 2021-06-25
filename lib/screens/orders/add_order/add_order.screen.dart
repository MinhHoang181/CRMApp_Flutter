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
      bottomNavigationBar: CreateOrderButton(),
    );
  }

  AppBar _addOrderScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Thêm đơn hàng'),
    );
  }
}

class CreateOrderButton extends StatelessWidget {
  const CreateOrderButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _createOrderButton(context);
  }

  BottomAppBar _createOrderButton(BuildContext context) {
    final total = context.select((Cart cart) => cart.totalCost);
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
                      NumberFormat('#,###').format(total) + ' đ',
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
                ElevatedButton(
                  child: Text('Tạo đơn hàng'),
                  onPressed: () => {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
