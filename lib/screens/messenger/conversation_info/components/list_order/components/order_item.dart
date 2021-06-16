import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
        child: Column(
          children: [
            _header(context, order),
            _detail(context, order),
            _footer(context, order),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context, Order order) {
    return Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(Layouts.SPACING / 2),
        child: Row(
          children: [
            Text(
              'Mã đơn hàng: ' + order.numberId.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detail(BuildContext context, Order order) {
    return Padding(
      padding: const EdgeInsets.all(Layouts.SPACING / 2),
      child: Table(
        children: [
          TableRow(
            children: [
              Text('Ngày tạo đơn:'),
              Text(order.dateCreated),
            ],
          ),
          TableRow(
            children: [
              Text('Người tạo đơn:'),
              Text(order.createBy),
            ],
          ),
          TableRow(
            children: [
              Text('Tổng tiền:'),
              Text(
                NumberFormat('#,###').format(order.cod),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _footer(BuildContext context, Order order) {
    return Padding(
      padding: const EdgeInsets.all(Layouts.SPACING / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Trạng thái: '),
          Text(
            order.status.text,
            style: TextStyle(
              color: order.status.color,
            ),
          ),
        ],
      ),
    );
  }
}
