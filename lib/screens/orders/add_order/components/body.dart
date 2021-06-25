import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Components
import 'total_cost_info.dart';
import 'product_order.dart';
import 'delivery_info.dart';
import 'payment_info.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).shadowColor.withOpacity(0.4),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  ProductOrder(),
                  TotalCostInfo(),
                  SizedBox(height: Layouts.SPACING / 2),
                  DeliveryInfo(),
                  SizedBox(height: Layouts.SPACING / 2),
                  PaymentInfo(),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
