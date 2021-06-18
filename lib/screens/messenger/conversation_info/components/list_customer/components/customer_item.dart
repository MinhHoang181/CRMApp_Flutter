import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:provider/provider.dart';

//Models
import 'package:cntt2_crm/models/Customer.dart';

class CustomerItem extends StatelessWidget {
  const CustomerItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customer = Provider.of<Customer>(context);
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: Layouts.SPACING / 2,
      ),
      child: Card(
        child: Column(
          children: [
            _header(context, customer),
            _detail(context, customer),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context, Customer customer) {
    return Container(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(Layouts.SPACING / 2),
        child: Row(
          children: [
            Text(
              customer.name != null ? customer.name : '---',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detail(BuildContext context, Customer customer) {
    return Padding(
      padding: const EdgeInsets.all(Layouts.SPACING / 2),
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(flex: 0.4),
        },
        children: [
          TableRow(
            children: [
              Text('Số điện thoại:'),
              Text(
                customer.phone != null ? customer.phone : '---',
              ),
            ],
          ),
          TableRow(
            children: [
              Text('Địa chỉ:'),
              Text(
                customer.address.fullAddress != null
                    ? customer.address.fullAddress
                    : '---',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
