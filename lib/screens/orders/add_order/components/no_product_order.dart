import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/images.dart' as Images;
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;
import 'package:provider/provider.dart';

//Screens
import 'package:cntt2_crm/screens/orders/add_order/select_product/select_product.screen.dart';

//Models
import 'package:cntt2_crm/models/Cart.dart';

class NoProductOrder extends StatelessWidget {
  final selectProductScreen;
  const NoProductOrder({Key key, @required this.selectProductScreen})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(bottom: Layouts.SPACING / 2),
        padding: EdgeInsets.all(Layouts.SPACING),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              color: Theme.of(context).shadowColor,
              blurRadius: 3,
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(Layouts.SPACING * 2),
              child: Image(
                image: AssetImage(Images.NO_PRODUCT_ORDER),
              ),
            ),
            Text(
              'Đơn hàng của bạn chưa có sản phẩm nào',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Fonts.SIZE_TEXT_MEDIUM,
                color: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .color
                    .withOpacity(0.5),
              ),
            ),
            SizedBox(height: Layouts.SPACING),
            Text(
              'Chọn sản phẩm',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Fonts.SIZE_TEXT_MEDIUM,
                color: Theme.of(context).primaryColor.withOpacity(0.7),
              ),
            )
          ],
        ),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: context.watch<Cart>(),
            child: SelectProductScreen(),
          ),
        ),
      ),
    );
  }
}
