import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/Order.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Order>(context);
    return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: Layouts.SPACING / 2,
        ),
        child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(Layouts.SPACING / 2),
            child: Table(
              children: [
                TableRow(
                  children: [
                    Text('Mã đơn hàng'),
                    Text('Ngày tạo'),
                    Text('Tạo bởi'),
                    Text('Thành tiền'),
                  ],
                ),
                TableRow(
                  children: [
                    Text(order.numberId.toString()),
                    Text(order.dateCreated),
                    Text(order.createBy),
                    Text(order.cod.toString()),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
