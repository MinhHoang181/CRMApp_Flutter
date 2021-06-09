import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;
import 'package:provider/provider.dart';

//Components
import 'order_manager.dart';

//Screens
import '../add_order/add_order.screen.dart';

//Models
import 'package:cntt2_crm/models/Cart.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              _createOrderButton(context),
              OrdersManager(),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _createOrderButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Layouts.SPACING * 2,
        vertical: Layouts.SPACING,
      ),
      padding: EdgeInsets.all(Layouts.SPACING),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: Theme.of(context).primaryColorLight,
          ),
        ],
      ),
      child: InkWell(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Icon(
                Icons.add_shopping_cart_rounded,
                color: Colors.white,
                size: 60,
              ),
              SizedBox(height: Layouts.SPACING / 2),
              Text(
                'Tạo đơn hàng mới',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: Fonts.SIZE_TEXT_LARGE),
              ),
            ],
          ),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => Cart(),
              child: AddOrderScreen(),
            ),
          ),
        ),
      ),
    );
  }
}
