import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//Models
import 'package:cntt2_crm/models/Shipper.dart';
import 'package:cntt2_crm/models/list_model/ShipperList.dart';

//Components
import 'shipper_item.dart';

class ListShipper extends StatelessWidget {
  ListShipper({Key key}) : super(key: key);

  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    final shippers = Provider.of<ShipperList>(context);
    return SmartRefresher(
      header: ClassicHeader(
        idleText: 'Kéo xuống để làm mới danh sách nhãn',
        releaseText: 'Thả ra để làm mới danh sách nhãn',
        refreshingText: 'Đang làm mới danh sách nhãn',
        completeText: 'Đã làm mới danh sách nhãn',
        failedText: 'Làm mới danh sách nhãn thất bại',
      ),
      onRefresh: () => _onRefresh(shippers),
      controller: _refreshController,
      child: ListView.builder(
        itemCount: shippers.map.length,
        itemBuilder: (context, index) => Provider<Shipper>.value(
          value: shippers.map.values.elementAt(index),
          child: ShipperItem(),
        ),
      ),
    );
  }

  void _onRefresh(ShipperList shippers) async {
    bool check = await shippers.refreshData();
    if (check) {
      _refreshController.refreshCompleted();
    } else {
      _refreshController.refreshFailed();
    }
  }
}
