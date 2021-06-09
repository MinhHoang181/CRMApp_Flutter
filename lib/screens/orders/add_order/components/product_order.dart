import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cntt2_crm/constants/images.dart' as Images;

//Models
import 'package:cntt2_crm/models/Product.dart';
import 'package:cntt2_crm/models/Cart.dart';

//Screens
import 'package:cntt2_crm/screens/orders/select_product/select_product.screen.dart';

class ProductOrder extends StatefulWidget {
  @override
  _ProductOrderState createState() => _ProductOrderState();
}

class _ProductOrderState extends State<ProductOrder> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final products = cart.products.keys.toList();

    return Container(
      padding: EdgeInsets.only(
        top: Layouts.SPACING,
        left: Layouts.SPACING,
        right: Layouts.SPACING,
      ),
      margin: EdgeInsets.only(bottom: Layouts.SPACING / 2),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => const Divider(),
            itemCount: products.length,
            itemBuilder: (context, index) =>
                _buildRow(context, products[index]),
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

  Widget _buildRow(BuildContext context, Product product) {
    int _total = Provider.of<Cart>(context).products[product];
    return ListTile(
      leading: product.image.isEmpty
          ? Image.asset(Images.IMAGE_HOLDER)
          : Image.network(product.image),
      title: Text(
        product.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SKU: ' + product.sku,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            NumberFormat('#,###').format(product.price),
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
      trailing: Text('$_total'),
    );
  }
}
