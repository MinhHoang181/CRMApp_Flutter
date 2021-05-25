import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/images.dart' as Images;
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;

class NoProductOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          Container(
            padding: EdgeInsets.all(Layouts.SPACING * 2),
            child: Image(
              image: AssetImage(Images.NO_PRODUCT_ORDER),
            ),
          ),
          Text(
            'Đơn hàng của bạn chưa có sản phẩm nào',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Fonts.SIZE_TEXT_MEDIUM,
              color:
                  Theme.of(context).textTheme.bodyText1.color.withOpacity(0.5),
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
    );
  }
}
