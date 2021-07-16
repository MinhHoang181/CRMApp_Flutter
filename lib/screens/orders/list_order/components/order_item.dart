import 'package:cntt2_crm/screens/orders/add_order/add_order.screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/Order/Order.dart';
import 'package:cntt2_crm/models/Order/CartProduct.dart';
import 'package:cntt2_crm/models/Cart.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Order>(context);
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: Layouts.SPACING / 2,
      ),
      child: InkWell(
        child: Card(
          child: Column(
            children: [
              _header(context, order),
              _detail(context, order),
              _footer(context, order),
            ],
          ),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider<Cart>.value(
              value: Cart.fromOrder(order),
              child: AddOrderScreen(
                order: order,
              ),
            ),
          ),
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
            _platform(order.conversationId),
            SizedBox(width: Layouts.SPACING / 2),
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
              Padding(
                padding: const EdgeInsets.only(bottom: Layouts.SPACING / 2),
                child: Text('Ngày tạo đơn:'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: Layouts.SPACING / 2),
                child: Text(order.dateCreated),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: Layouts.SPACING / 2),
                child: Text('Người tạo đơn:'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: Layouts.SPACING / 2),
                child: Text(order.createBy),
              ),
            ],
          ),
          if (order.customer != null) ...[
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: Layouts.SPACING / 2),
                  child: Text('Khách hàng:'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Layouts.SPACING / 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(order.customer.name),
                      SizedBox(height: Layouts.SPACING / 2),
                      Text('(điện thoại: ' + order.customer.phone + ')'),
                    ],
                  ),
                )
              ],
            ),
          ],
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: Layouts.SPACING / 2),
                child: Text('Tổng tiền:'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: Layouts.SPACING / 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      NumberFormat('#,###').format(order.amount) + 'đ',
                    ),
                    SizedBox(width: Layouts.SPACING / 2),
                    Text(
                      '(COD: ' + NumberFormat('#,###').format(order.cod) + 'đ)',
                    ),
                  ],
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: Layouts.SPACING / 2),
                child: Text('Sản phẩm:'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: Layouts.SPACING / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    order.products.length,
                    (index) => _productText(
                      order.products[index],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (order.address.hasAddress) ...[
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: Layouts.SPACING / 2),
                  child: Text('Địa chỉ:'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Layouts.SPACING / 2),
                  child: Text(
                    order.address.fullAddress,
                  ),
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
              Flexible(
                child: Text(
                  product.name + ' (' + product.attributesToString() + ')',
                ),
              ),
            ],
          ),
          Text('số lượng: ' + product.quantity.toString()),
        ],
      ),
    );
  }

  Widget _platform(String conversationId) {
    return conversationId != null ? Icon(Icons.facebook) : Icon(Icons.web);
  }
}
