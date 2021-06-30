import 'package:cntt2_crm/models/Order/FilterOrder.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
//Components
import 'components/body.dart';

class ListOrderScreen extends StatelessWidget {
  final FilterOrder filterOrderTab;
  const ListOrderScreen({Key key, this.filterOrderTab}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int indexTab = 0;
    switch (filterOrderTab) {
      case FilterOrder.all:
        indexTab = 0;
        break;
      case FilterOrder.status_new:
        indexTab = 1;
        break;
      case FilterOrder.status_confirmed:
        indexTab = 2;
        break;
      case FilterOrder.status_sent:
        indexTab = 3;
        break;
      case FilterOrder.status_done:
        indexTab = 4;
        break;
      default:
        indexTab = 0;
    }
    return DefaultTabController(
      length: 5,
      initialIndex: indexTab,
      child: Scaffold(
        appBar: _listOrderScreenAppBar(context),
        body: TabBarView(
          children: [
            Body(
              filterOrder: FilterOrder.all,
            ),
            Body(
              filterOrder: FilterOrder.status_new,
            ),
            Body(
              filterOrder: FilterOrder.status_confirmed,
            ),
            Body(
              filterOrder: FilterOrder.status_sent,
            ),
            Body(
              filterOrder: FilterOrder.status_done,
            ),
          ],
        ),
      ),
    );
  }

  AppBar _listOrderScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Danh sách đơn hàng'),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: _toolBar(context),
      ),
    );
  }

  Widget _toolBar(BuildContext context) {
    return Column(
      children: [
        _searchBar(context),
        SizedBox(height: Layouts.SPACING / 2),
        _filterBar(),
      ],
    );
  }

  Widget _searchBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Layouts.SPACING),
      height: 45,
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        style: Theme.of(context).textTheme.bodyText2,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: "Nhập tên, số điện thoại, mã đơn hàng",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget _filterBar() {
    return Align(
      alignment: Alignment.centerLeft,
      child: TabBar(
        isScrollable: true,
        tabs: [
          Tab(
            text: 'Tất cả',
          ),
          Tab(
            text: 'Mới',
          ),
          Tab(
            text: 'Đã xác nhận',
          ),
          Tab(
            text: 'Đã gửi đi',
          ),
          Tab(
            text: 'Đã nhận hàng',
          ),
        ],
      ),
    );
  }
}
