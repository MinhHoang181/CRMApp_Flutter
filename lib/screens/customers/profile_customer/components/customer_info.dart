import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:provider/provider.dart';

//Models
import 'package:cntt2_crm/models/Customer.dart';

class CustomerInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _address(context),
      ],
    );
  }

  Widget _address(BuildContext context) {
    final address = Provider.of<Customer>(context).address;
    return Container(
      padding: EdgeInsets.all(Layouts.SPACING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Địa chỉ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color:
                  Theme.of(context).textTheme.bodyText1.color.withOpacity(0.5),
            ),
          ),
          SizedBox(height: Layouts.SPACING / 2),
          Text(address != null ? address.fullAddress : '---'),
        ],
      ),
    );
  }
}
