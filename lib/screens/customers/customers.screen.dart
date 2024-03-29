import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Screens
import 'components/no_customer.screen.dart';
import 'list_customer/list_customer.screen.dart';

//Models
import 'package:cntt2_crm/models/Customer.dart';

List<Customer> customers = [];

class CustomersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return customers.isEmpty
        ? NoCustomerScreen()
        : Provider.value(
            value: customers,
            child: ListCustomerScreen(),
          );
  }
}
