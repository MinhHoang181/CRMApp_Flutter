import 'package:cntt2_crm/models/Order/FilterOrder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Components
import 'order_item.dart';

//Models
import 'package:cntt2_crm/models/Order/Order.dart';
import 'package:cntt2_crm/models/list_model/OrderList.dart';

class ListOrder extends StatelessWidget {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return _listOrder(context);
  }

  void _onRefresh(FilterOrder filterOrder, OrderList orderList) async {
    await orderList.refreshDataWithFilter(filterOrder);
    _refreshController.refreshCompleted();
  }

  void _onLoading(FilterOrder filterOrder, OrderList orderList) async {
    bool check = await orderList.loadMoreDataWithFilter(filterOrder);
    if (check) {
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }

  Widget _listOrder(BuildContext context) {
    final filterOrder = context.watch<FilterOrder>();
    final orders = context.watch<OrderList>();
    return Container(
      color: Theme.of(context).colorScheme.onBackground,
      margin: EdgeInsets.only(top: Layouts.SPACING / 2),
      child: SmartRefresher(
        header: ClassicHeader(
          idleText: 'Kéo xuống để làm mới danh sách đơn hàng',
          releaseText: 'Thả ra để làm mới danh sách đơn hàng',
          refreshingText: 'Đang làm mới danh sách đơn hàng',
          completeText: 'Đã làm mới danh sách đơn hàng',
          failedText: 'Làm mới danh sách đơn hàng thất bại',
        ),
        enablePullUp: orders.pageInfo.hasNextPage ? true : false,
        footer: ClassicFooter(
          canLoadingText: 'Tải thêm đơn hàng',
          loadingText: 'Đang tải thêm đơn hàng',
          noDataText: 'Đã tải hết đơn hàng',
          failedText: 'Tải đơn hàng thất bại',
        ),
        onRefresh: () => _onRefresh(filterOrder, orders),
        onLoading: () => _onLoading(filterOrder, orders),
        controller: _refreshController,
        child: ListView.builder(
            itemCount: orders.filter(filterOrder).length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider<Order>.value(
                value: orders.filter(filterOrder).values.elementAt(index),
                child: OrderItem(),
              );
            }),
      ),
    );
  }
}
