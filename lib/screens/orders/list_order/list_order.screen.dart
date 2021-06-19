import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;
//Components
import 'components/body.dart';

class ListOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: _listOrderScreenAppBar(context),
        body: TabBarView(
          children: [
            Body(),
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
        child: _toolBar(),
      ),
    );
  }

  Widget _toolBar() {
    return Column(
      children: [
        _searchBar(),
        SizedBox(height: Layouts.SPACING / 2),
        _filterBar(),
      ],
    );
  }

  Widget _searchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Layouts.SPACING),
      height: 45,
      child: TextField(
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: "Nhập tên, số điện thoại, mã đơn hàng",
        ),
      ),
    );
  }

  Widget _filterBar() {
    return Row(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                text: 'Tất cả',
              ),
            ],
          ),
        ),
        Spacer(),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Icon(Icons.filter_alt_rounded),
            color: Colors.white,
            onPressed: () => {},
          ),
        ),
      ],
    );
  }
}
