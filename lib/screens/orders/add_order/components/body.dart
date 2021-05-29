import 'package:flutter/material.dart';

//Models
import 'package:cntt2_crm/models/Cart.dart';
import 'package:provider/provider.dart';

//Components
import 'no_product_order.dart';
import 'total_cost_info.dart';
import 'add_note.dart';
import 'payment_method.dart';
import 'customer_info.dart';
import 'product_order.dart';

//Screens
import '../../select_product/select_product.screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                if (cart.products.isEmpty) ...[
                  InkWell(
                    child: NoProductOrder(),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider.value(
                          value: cart,
                          child: SelectProductScreen(),
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  ProductOrder(),
                ],
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
