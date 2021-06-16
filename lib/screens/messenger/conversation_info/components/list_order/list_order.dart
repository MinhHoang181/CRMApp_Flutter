import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Components
import 'components/order_item.dart';

//Models
import 'package:cntt2_crm/models/Order/Order.dart';
import 'package:cntt2_crm/models/list_model/OrderList.dart';

class ListOrder extends StatelessWidget {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return _listNode(context);
  }

  void _onRefresh(OrderList orderList) async {
    await orderList.refreshData();
    _refreshController.refreshCompleted();
  }

  void _onLoading(OrderList orderList) async {
    bool check = await orderList.loadMoreData();
    if (check) {
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }

  Widget _listNode(BuildContext context) {
    final orderList = Provider.of<OrderList>(context);
    List<Order> orders = orderList.list;
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
        enablePullUp: orderList.pageInfo.hasNextPage ? true : false,
        footer: ClassicFooter(
          canLoadingText: 'Tải thêm đơn hàng',
          loadingText: 'Đang tải thêm đơn hàng',
          noDataText: 'Đã tải hết đơn hàng',
          failedText: 'Tải đơn hàng thất bại',
        ),
        onRefresh: () => _onRefresh(orderList),
        onLoading: () => _onLoading(orderList),
        controller: _refreshController,
        child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider<Order>.value(
                value: orders[index],
                child: OrderItem(),
              );
            }),
      ),
    );
  }

  Widget _headerList(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: Layouts.SPACING / 2,
        vertical: Layouts.SPACING,
      ),
      child: Table(
        children: [
          TableRow(
            children: [
              Text(
                'Mã đơn hàng',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Ngày tạo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Tạo bởi',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Thành tiền',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Trạng thái',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
