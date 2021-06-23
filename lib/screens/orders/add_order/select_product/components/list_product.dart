import 'package:cntt2_crm/models/Cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//Components
import 'product_item.dart';

//Models
import 'package:cntt2_crm/models/Product/Product.dart';
import 'package:cntt2_crm/models/list_model/ProductList.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({Key key}) : super(key: key);

  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  final RefreshController _refreshController = RefreshController();
  void _onRefresh(ProductList products) async {
    bool check = await products.refreshData();
    if (check) {
      _refreshController.refreshCompleted();
      return;
    }
    _refreshController.refreshFailed();
  }

  void _onLoading(ProductList products) async {
    bool check = await products.loadMoreData();
    if (mounted) setState(() {});
    if (check) {
      _refreshController.loadComplete();
      return;
    }
    _refreshController.loadFailed();
  }

  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<ProductList>(context);
    final cart = Provider.of<Cart>(context);
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
        failedText: 'Tải sản phẩm thất bại',
      ),
      onRefresh: () => _onRefresh(productList),
      onLoading: () {
        _onLoading(productList);
      },
      controller: _refreshController,
      child: ListView.builder(
        itemCount: productList.map.length,
        itemBuilder: (context, index) {
          return MultiProvider(
            providers: [
              Provider<Product>.value(
                  value: productList.map.values.elementAt(index)),
              ChangeNotifierProvider<Cart>.value(value: cart),
            ],
            child: ProductItem(),
          );
        },
      ),
    );
  }
}
