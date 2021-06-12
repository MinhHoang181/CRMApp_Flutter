import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:provider/provider.dart';

//Models
import 'package:cntt2_crm/models/Customer.dart';

//Screens
import 'package:cntt2_crm/screens/customers/profile_customer/profile_customer.screen.dart';

class Body extends StatelessWidget {
  Widget build(BuildContext context) {
    List<Customer> customers = Provider.of<List<Customer>>(context);
    return Container(
      color: Theme.of(context).colorScheme.onBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: Layouts.SPACING / 2,
              bottom: Layouts.SPACING / 2,
              left: Layouts.SPACING,
            ),
            child: Text(
              customers.length.toString() + ' khách hàng',
            ),
          ),
          _listOrder(context, customers),
        ],
      ),
    );
  }

  Widget _listOrder(BuildContext context, List<Customer> customers) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Expanded(
        child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => Divider(),
          itemCount: customers.length,
          itemBuilder: (context, index) => _buildRow(context, customers[index]),
        ),
      )
    );
  }

  Widget _buildRow(BuildContext context, Customer customer) {
    return ListTile(
      title:
      Text(
        customer.name,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            customer.phone == null ? '---' : customer.phone,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            customer.address == null ? '---' : customer.address.toString(),
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Provider.value(
            value: customer,
            child: ProfileCustomerScreen(),
          ),
        ),
      ),
    );
  }
}
