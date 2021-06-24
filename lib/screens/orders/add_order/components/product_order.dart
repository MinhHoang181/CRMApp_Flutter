import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//Models
import 'package:cntt2_crm/models/Cart.dart';
import 'package:cntt2_crm/models/Product/Photo.dart';
import 'package:cntt2_crm/models/Product/Variant.dart';

//Screens
import '../select_product/select_product.screen.dart';

//Components
import 'package:cntt2_crm/components/image_item.dart';

class ProductOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Container(
      margin: EdgeInsets.all(Layouts.SPACING / 2),
      child: Column(
        children: [
          ListView(
            shrinkWrap: true,
            children: List.generate(
              cart.products.length,
              (index) => _buildRow(
                context,
                cart.products.keys.elementAt(index),
              ),
            ),
          ),
          TextButton(
            child: Text(
              'Thêm sản phẩm',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider.value(
                  value: cart,
                  child: SelectProductScreen(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, Variant variant) {
    final cart = Provider.of<Cart>(context);
    return Slidable(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(Layouts.SPACING / 2),
          child: Row(
            children: [
              _imageProduct(variant.product.photos),
              SizedBox(width: Layouts.SPACING),
              Expanded(
                child: _productInfo(context, variant),
              ),
              SizedBox(width: Layouts.SPACING),
              _quantity(context, cart, variant)
            ],
          ),
        ),
      ),
      secondaryActions: [
        IconSlideAction(
          icon: Icons.delete_rounded,
          caption: 'Xoá',
          color: Colors.red,
          onTap: () => cart.delete(variant),
        ),
      ],
      actionPane: SlidableScrollActionPane(),
    );
  }

  Widget _imageProduct(List<Photo> photos) {
    final double size = 60;
    return ImageItem(
      url: photos.isNotEmpty ? photos[0].url : null,
      size: Size(size, size),
    );
  }

  Widget _productInfo(BuildContext context, Variant variant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          variant.product.name,
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontSize: Theme.of(context).textTheme.subtitle1.fontSize - 2,
                color: Colors.blue,
              ),
        ),
        SizedBox(height: Layouts.SPACING / 2),
        Text(
          variant.attributesToString(),
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: Theme.of(context).textTheme.bodyText1.fontSize + 2,
              ),
        ),
        SizedBox(height: Layouts.SPACING / 2),
        Text(
          NumberFormat('#,### đ').format(variant.finalPrice),
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontSize: Theme.of(context).textTheme.subtitle1.fontSize - 4,
                color: Colors.yellow[700],
              ),
        ),
      ],
    );
  }

  Widget _quantity(BuildContext context, Cart cart, Variant variant) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          iconSize: 20,
          icon: Icon(Icons.remove),
          onPressed: () => cart.remove(variant),
        ),
        Text(
          cart.products[variant].toString(),
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontSize: Theme.of(context).textTheme.subtitle1.fontSize - 4,
              ),
        ),
        IconButton(
          iconSize: 20,
          icon: Icon(Icons.add),
          onPressed: () => cart.add(variant),
        ),
      ],
    );
  }
}
