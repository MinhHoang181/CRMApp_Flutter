import 'package:badges/badges.dart';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/Product/Product.dart';
import 'package:cntt2_crm/models/Product/Variant.dart';
import 'package:cntt2_crm/models/Cart.dart';
import 'package:cntt2_crm/models/Product/Photo.dart';
import 'package:cntt2_crm/models/list_model/VariantList.dart';

//Components
import 'package:cntt2_crm/screens/components/image_item.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return ExpandablePanel(
      header: _product(context),
      collapsed: null,
      expanded: FutureBuilder<VariantList>(
        future: product.variants.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data.map.isEmpty
                ? _noVariant()
                : _listVariant(context, snapshot.data);
          } else if (snapshot.hasError) {
            print(snapshot.error.toString());
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _product(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    final totalSelect = cart.totalSelectOfProduct(product);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Badge(
          toAnimate: false,
          showBadge: totalSelect > 0 ? true : false,
          badgeContent: Text(
            totalSelect > 0 ? totalSelect.toString() : '',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          badgeColor: Colors.blueAccent,
          padding: EdgeInsets.all(8),
          child: _imageProduct(product.featuredPhoto),
        ),
        SizedBox(width: Layouts.SPACING),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      fontSize:
                          Theme.of(context).textTheme.subtitle1.fontSize - 4,
                    ),
              ),
              SizedBox(height: Layouts.SPACING / 2),
              Text('Mã sản phẩm: ' + product.numberId.toString()),
              SizedBox(height: Layouts.SPACING / 2),
              Text('Tồn kho: ' + product.total.toString()),
            ],
          ),
        ),
        SizedBox(width: Layouts.SPACING),
        Expanded(
          flex: 2,
          child:
              _price(context, product.salePrice, product.price, product.total),
        ),
      ],
    );
  }

  Widget _listVariant(BuildContext context, VariantList variantList) {
    return Padding(
      padding: const EdgeInsets.all(Layouts.SPACING / 2),
      child: Column(
        children: [
          _headListVariant(context),
          SizedBox(height: Layouts.SPACING / 2),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => Divider(),
            itemCount: variantList.map.length,
            itemBuilder: (context, index) =>
                _variant(context, variantList.map.values.elementAt(index)),
          ),
        ],
      ),
    );
  }

  Widget _headListVariant(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Center(
            child: Text(
              'Mã vạch',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Center(
            child: Text(
              'Mẫu mã',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              'Tồn',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Center(
            child: Text(
              'Giá bán',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _variant(BuildContext context, Variant variant) {
    final cart = Provider.of<Cart>(context);
    final totalSelect =
        cart.products.containsKey(variant) ? cart.products[variant] : 0;
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Layouts.SPACING / 2),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Badge(
                toAnimate: false,
                showBadge: cart.products.containsKey(variant) ? true : false,
                badgeContent: Text(
                  totalSelect > 0 ? totalSelect.toString() : '',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                badgeColor: Colors.blueAccent,
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    variant.barcode != null ? variant.barcode : '---',
                  ),
                ),
              ),
            ),
            SizedBox(width: Layouts.SPACING / 2),
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  variant.attributesToString(),
                ),
              ),
            ),
            SizedBox(width: Layouts.SPACING / 2),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  variant.total.toString(),
                ),
              ),
            ),
            SizedBox(width: Layouts.SPACING / 2),
            Expanded(
              flex: 3,
              child: _price(
                  context, variant.salePrice, variant.price, variant.total),
            ),
          ],
        ),
      ),
      onTap: variant.total == 0 || totalSelect >= variant.total
          ? null
          : () => _addToCart(context, variant),
    );
  }

  void _addToCart(BuildContext context, Variant variant) {
    final isMutil = Provider.of<bool>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    cart.add(variant);
    if (!isMutil) Navigator.of(context).pop();
  }

  Widget _price(
      BuildContext context, double salePrice, double price, int total) {
    return total > 0
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (salePrice == null && price != null) ...[
                Text(
                  NumberFormat('#,### đ').format(price),
                ),
              ],
              if (salePrice != null) ...[
                Text(
                  NumberFormat('#,### đ').format(salePrice),
                ),
                Text(
                  NumberFormat('#,### đ').format(price),
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        decoration: TextDecoration.lineThrough,
                      ),
                ),
              ],
            ],
          )
        : _outOfStock(context);
  }

  Widget _imageProduct(Photo photo) {
    final double size = 80;
    return ImageItem(
      url: photo != null ? photo.url : null,
      size: Size(size, size),
    );
  }

  Widget _noVariant() {
    return Container(
      height: 40,
      child: Center(
        child: Text('Không có mẫu mã sản phẩm'),
      ),
    );
  }

  Widget _outOfStock(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80,
          decoration: BoxDecoration(
            color: Colors.redAccent.withOpacity(0.3),
            border: Border.all(
              color: Colors.redAccent,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              'Hết hàng',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.red[700],
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
