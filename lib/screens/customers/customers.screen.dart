import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Screens
import 'components/no_customer.screen.dart';
import 'list_customer/list_customer.screen.dart';

//Models
import 'package:cntt2_crm/models/Customer.dart';

List<Customer> customers = [
  Customer(
    name: 'Tùng',
    phone: '0898191991',
  ),
  Customer(
    name: 'Đại Hùng',
    phone: '0359110375',
    address: Address(
      province: 'HCM',
      district: 'Q7',
      ward: 'Tân Hưng',
      address: '19 Nguyễn Hữu Thọ',
    ),
  ),
  Customer(
    name: 'Ngô Liên',
    address: Address(
      province: 'HCM',
      district: 'Q4',
      ward: 'Phường 10',
      address: '777 Vĩnh Khánh',
    ),
  ),
];

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
