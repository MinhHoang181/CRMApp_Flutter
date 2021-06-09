import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Components
import 'components/body.dart';

//Screens
import '../add_customer/add_customer.screen.dart';

class ListCustomerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _customerScreenAppBar(context),
        body: TabBarView(
          children: [
            Body(),
            Body(),
          ],
        ),
      ),
    );
  }

  AppBar _customerScreenAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Text('Quản lý khách hàng'),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Column(
          children: [
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: Layouts.SPACING,
                vertical: Layouts.SPACING / 2,
              ),
              child: TextField(
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search_rounded, color: Colors.grey,),
                  hintText: 'Nhập tên, số điện thoại, mã',
                ),
              ),
            ),
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(
                        text: 'Tất cả',
                      ),
                      Tab(
                        text: 'Đang giao dịch',
                      ),
                    ],
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.filter_alt_rounded,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: () => {},
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.group_rounded),
          onPressed: () => {},
        ),
        IconButton(
          icon: Icon(Icons.person_add_alt_1_rounded),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCustomerScreen(),
            ),
          ),
        ),
      ],
    );
  }
}
