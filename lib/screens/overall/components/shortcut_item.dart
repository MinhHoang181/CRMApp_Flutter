import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/icons.dart' as MyIcons;
import 'package:provider/provider.dart';

//Models
import 'package:cntt2_crm/models/Cart.dart';
import 'package:cntt2_crm/models/Order/FilterOrder.dart';
//Screens
import 'package:cntt2_crm/screens/orders/add_order/add_order.screen.dart';
import 'package:cntt2_crm/screens/orders/list_order/list_order.screen.dart';

class ShortCut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        children: [
          TableRow(children: [
            InkWell(
              child: Column(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Image(
                      image: AssetImage(MyIcons.ADD_BILL),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                  ),
                  Text(
                    'Thêm \n đơn hàng',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider(
                    create: (context) => Cart(),
                    child: AddOrderScreen(),
                  ),
                ),
              ),
            ),
            InkWell(
              child: Column(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Image(
                      image: AssetImage(MyIcons.PAY_BILL),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                  ),
                  Text(
                    'Hóa đơn đã \n thanh toán',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ListOrderScreen(
                    filterOrderTab: FilterOrder.status_done,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Image(
                    image: AssetImage(MyIcons.MESSAGE_ALT),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                ),
                Text(
                  'Tin nhắn \n tổng hợp',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
            InkWell(
              child: Column(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Image(
                      image: AssetImage(MyIcons.ALL_BILL),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                  ),
                  Text(
                    'Tất cả \n hóa đơn',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ListOrderScreen(
                    filterOrderTab: FilterOrder.all,
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
