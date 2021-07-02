import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Components
import 'components/customer_item.dart';
import 'components/empty_list_customer.dart';

//Models
import 'package:cntt2_crm/models/Customer.dart';
import 'package:cntt2_crm/models/list_model/CustomerList.dart';

class ListCustomer extends StatelessWidget {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return _listCustomer(context);
  }

  void _onRefresh(CustomerList customerList) async {
    await customerList.refreshData();
    _refreshController.refreshCompleted();
  }

  Widget _listCustomer(BuildContext context) {
    final customers = Provider.of<CustomerList>(context);
    return Container(
      color: Theme.of(context).colorScheme.onBackground,
      margin: EdgeInsets.only(top: Layouts.SPACING / 2),
      child: SmartRefresher(
        header: ClassicHeader(
          idleText: 'Kéo xuống để làm mới danh sách khách hàng',
          releaseText: 'Thả ra để làm mới danh sách khách hàng',
          refreshingText: 'Đang làm mới danh sách khách hàng',
          completeText: 'Đã làm mới danh sách khách hàng',
          failedText: 'Làm mới danh sách khách hàng thất bại',
        ),
        onRefresh: () => _onRefresh(customers),
        controller: _refreshController,
        child: _buidList(context, customers),
      ),
    );
  }

  Widget _buidList(BuildContext context, CustomerList customers) {
    return customers.map.isEmpty
        ? EmptyListCustomer()
        : ListView.builder(
            itemCount: customers.map.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider<Customer>.value(
                value: customers.map.values.elementAt(index),
                child: CustomerItem(),
              );
            },
          );
  }
}
