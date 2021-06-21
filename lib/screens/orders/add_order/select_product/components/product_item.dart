import 'package:cntt2_crm/models/list_model/VariantList.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cntt2_crm/constants/images.dart' as MyImage;
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/Product/Product.dart';
import 'package:cntt2_crm/models/Product/Variant.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return ExpandablePanel(
      header: _product(context),
      collapsed: null,
      expanded: FutureBuilder(
        future: product.variants.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _listVariant(context, snapshot.data);
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          MyImage.IMAGE_HOLDER,
          height: 100,
          width: 100,
        ),
        SizedBox(width: Layouts.SPACING),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                product.name,
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      fontSize:
                          Theme.of(context).textTheme.subtitle1.fontSize - 2,
                    ),
              ),
              SizedBox(height: Layouts.SPACING / 2),
              Text('Mã sản phẩm: ' + product.numberId.toString()),
            ],
          ),
        ),
        SizedBox(width: Layouts.SPACING),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Giá bán',
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: Layouts.SPACING / 2),
              if (product.salePrice == null && product.inPrice == null) ...[
                Text(
                  NumberFormat('#,### đ').format(product.price),
                ),
              ],
              if (product.salePrice != null) ...[
                Text(
                  NumberFormat('#,### đ').format(product.salePrice),
                ),
                SizedBox(height: Layouts.SPACING / 2),
                Text(
                  NumberFormat('#,### đ').format(product.price),
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        decoration: TextDecoration.lineThrough,
                      ),
                ),
              ],
            ],
          ),
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
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Center(
            child: Text(
              variant.barcode,
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
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (variant.salePrice == null && variant.inPrice == null) ...[
                Text(
                  NumberFormat('#,### đ').format(variant.price),
                ),
              ],
              if (variant.salePrice != null) ...[
                Text(
                  NumberFormat('#,### đ').format(variant.salePrice),
                ),
                Text(
                  NumberFormat('#,### đ').format(variant.price),
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        decoration: TextDecoration.lineThrough,
                      ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
