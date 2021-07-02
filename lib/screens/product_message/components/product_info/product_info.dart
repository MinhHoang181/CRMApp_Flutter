import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/ProductMessage.dart';
import 'package:cntt2_crm/models/Product/Product.dart';

//Components
import 'components/photo_product.dart';
import 'components/attribute_product.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = context
        .select((ProductMessage productMessage) => productMessage.product);
    return product == null
        ? _emptyProduct(context)
        : _productInfo(context, product);
  }

  Widget _emptyProduct(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Chưa chọn sản phẩm nào'),
      ),
    );
  }

  Widget _productInfo(BuildContext context, Product product) {
    return Container(
      padding: const EdgeInsets.all(Layouts.SPACING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PhotoProduct(),
          _basicInfo(context, product),
          AttributeProduct(),
        ],
      ),
    );
  }

  Widget _basicInfo(BuildContext context, Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(height: Layouts.SPACING / 2),
        Text(
          'Mã sản phẩm: ' + product.numberId.toString(),
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontSize: Theme.of(context).textTheme.subtitle1.fontSize - 3,
              ),
        ),
        SizedBox(height: Layouts.SPACING / 2),
        _PriceProduct(),
      ],
    );
  }
}

class _PriceProduct extends StatelessWidget {
  const _PriceProduct({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasPrice = context
        .select((ProductMessage productMessage) => productMessage.hasPrice);
    final product = context
        .select((ProductMessage productMessage) => productMessage.product);
    return hasPrice ? _price(context, product.finalPrice) : Container();
  }

  Widget _price(BuildContext context, double price) {
    return Text(
      'Giá: ' + NumberFormat('#,### đ').format(price),
      style: Theme.of(context).textTheme.bodyText2.copyWith(
            fontSize: Theme.of(context).textTheme.subtitle1.fontSize - 3,
          ),
    );
  }
}
