import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;

//Components
import 'components/no_product_order.dart';
import 'components/total_cost_info.dart';
import 'components/customer_info.dart';
import 'components/payment_method.dart';
import 'components/add_note.dart';

class AddOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _addOrderScreenAppBar(context),
      body: _Body(),
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
                      '0',
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

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                NoProductOrder(),
                TotalCostInfo(),
                CustomerInfo(),
                PaymentMethod(),
                AddNote(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
