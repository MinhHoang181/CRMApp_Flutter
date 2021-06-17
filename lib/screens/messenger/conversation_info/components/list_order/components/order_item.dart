import 'package:cntt2_crm/models/Order/CartProduct.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/Order/Order.dart';

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
            Spacer(),
            Icon(order.type.icon),
            SizedBox(width: Layouts.SPACING / 2),
            Text(order.type.text),
          ],
        ),
      ),
    );
  }

  Widget _detail(BuildContext context, Order order) {
    return Padding(
      padding: const EdgeInsets.all(Layouts.SPACING / 2),
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(flex: 0.4),
        },
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    NumberFormat('#,###').format(order.amount) + 'đ',
                  ),
                  Text(
                    '(COD: ' + NumberFormat('#,###').format(order.cod) + 'đ)',
                  ),
                ],
              ),
            ],
          ),
          TableRow(
            children: [
              Text('Sản phẩm:'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  order.products.length,
                  (index) => _productText(
                    order.products[index],
                  ),
                ),
              ),
            ],
          ),
          if (order.address.hasAddress) ...[
            TableRow(
              children: [
                Text('Địa chỉ:'),
                Text(
                  order.address.fullAddress,
                )
              ],
            ),
          ],
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

  Widget _productText(CartProduct product) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.circle,
                size: 5,
              ),
              SizedBox(width: Layouts.SPACING / 2),
              Text(
                product.name + ' (' + product.attributesToString() + ')',
              ),
            ],
          ),
          Text('số lượng: ' + product.quantity.toString()),
        ],
      ),
    );
  }
}
