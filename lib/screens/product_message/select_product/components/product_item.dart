import 'package:cntt2_crm/models/ProductMessage.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/Product/Product.dart';
import 'package:cntt2_crm/models/Product/Variant.dart';
import 'package:cntt2_crm/models/Product/Photo.dart';
import 'package:cntt2_crm/models/list_model/VariantList.dart';

//Components
import 'package:cntt2_crm/components/image_item.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _product(context);
  }

  Widget _product(BuildContext context) {
    final product = Provider.of<Product>(context);
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _imageProduct(product.featuredPhoto),
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
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        final productMessage =
            Provider.of<ProductMessage>(context, listen: false);
        productMessage.product = product;
        Navigator.of(context).pop();
      },
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
      ],
    );
  }

  Widget _variant(BuildContext context, Variant variant) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Layouts.SPACING / 2),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  variant.barcode != null ? variant.barcode : '---',
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
          ],
        ),
      ),
      onTap: () => {},
    );
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
}
