import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/Product/Product.dart';
import 'package:cntt2_crm/models/Product/Photo.dart';
import 'package:cntt2_crm/models/ProductMessage.dart';

//Components
import 'package:cntt2_crm/screens/components/image_item.dart';

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

  Widget _imageProduct(Photo photo) {
    final double size = 80;
    return ImageItem(
      url: photo != null ? photo.url : null,
      size: Size(size, size),
    );
  }
}
