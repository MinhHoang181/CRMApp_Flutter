import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//Components
import 'product_item.dart';

//Models
import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/Product/Product.dart';
import 'package:cntt2_crm/models/list_model/ProductList.dart';

class ListProduct extends StatelessWidget {
  final RefreshController _refreshController = RefreshController();

  void _onRefresh() async {
    await AzsalesData.instance.products.refreshData();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    bool check = await AzsalesData.instance.products.loadMoreData();
    if (check) {
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<ProductList>(context);
    return SmartRefresher(
      header: ClassicHeader(
        idleText: 'Kéo xuống để làm mới danh sách sản phẩm',
        releaseText: 'Thả ra để làm mới danh sách sản phẩm',
        refreshingText: 'Đang làm mới danh sách sản phẩm',
        completeText: 'Đã làm mới danh sách sản phẩm',
        failedText: 'Làm mới danh sách sản phẩm thất bại',
      ),
      enablePullUp: productList.pageInfo.hasNextPage ? true : false,
      footer: ClassicFooter(
        canLoadingText: 'Tải thêm sản phẩm',
        loadingText: 'Đang tải thêm sản phẩm',
        noDataText: 'Đã tải hết sản phẩm',
        failedText: 'Tải tin nhắn sản phẩm',
      ),
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      controller: _refreshController,
      child: ListView.builder(
        itemCount: productList.map.length,
        itemBuilder: (context, index) {
          return Provider<Product>.value(
            value: productList.map.values.elementAt(index),
            child: ProductItem(),
          );
        },
      ),
    );
  }
}
