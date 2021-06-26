import 'package:flutter/material.dart';
import 'package:cntt2_crm/models/Order/FilterOrder.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Components
import 'components/body.dart';

class ReturnOrderScreen extends StatelessWidget {
  const ReturnOrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _listOrderScreenAppBar(context),
        body: TabBarView(
          children: [
            Body(
              filterOrder: FilterOrder.status_return_all,
            ),
            Body(
              filterOrder: FilterOrder.status_returning,
            ),
            Body(
              filterOrder: FilterOrder.status_returned,
            ),
          ],
        ),
      ),
    );
  }

  AppBar _listOrderScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Danh sách đơn hàng trả lại'),
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
            text: 'Đang trả hàng',
          ),
          Tab(
            text: 'Đã trả hàng',
          ),
        ],
      ),
    );
  }
}
