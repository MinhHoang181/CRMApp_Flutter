import 'package:cntt2_crm/screens/customers/profile_customer/components/contact_info.dart';
import 'package:flutter/material.dart';

//Components
import 'components/contact_info.dart';
import 'components/customer_history.dart';
import 'components/customer_info.dart';

class ProfileCustomerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _profileCustomerScreenAppBar(context),
        body: TabBarView(
          children: [
            CustomerInfo(),
            CustomerHistory(),
          ],
        ),
      ),
    );
  }

  AppBar _profileCustomerScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Khách hàng'),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(160),
        child: Column(
          children: [
            ContactInfo(),
            Divider(height: 0),
            _tabBar(context),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add_shopping_cart_rounded),
          onPressed: () => {},
        ),
        IconButton(
          icon: Icon(Icons.edit_rounded),
          onPressed: () => {},
        ),
      ],
    );
  }

  Widget _tabBar(BuildContext context) {
    return Material(
      child: TabBar(
        tabs: [
          Tab(
            text: 'Thông tin',
          ),
          Tab(
            text: 'Lịch sử',
          )
        ],
      ),
    );
  }
}
