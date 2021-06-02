import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/images.dart' as Images;
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:intl/intl.dart';

//Models
import 'package:cntt2_crm/models/Product.dart';
import 'package:cntt2_crm/models/Cart.dart';
import 'package:provider/provider.dart';

List<Product> _products = [
  Product(id: '1', name: 'Iphone XS', total: 2, sku: 'PVN01', price: 8000000),
  Product(id: '2', name: 'Iphone 11', total: 3, sku: 'PVN02', price: 18000000),
];

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Layouts.SPACING),
      child: ListView.builder(
        itemCount: _products.length * 2,
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;
          return _buildRow(context, _products[index]);
        },
      ),
    );
  }

  Widget _buildRow(BuildContext context, Product product) {
    final cart = Provider.of<Cart>(context);
    final _total = cart.products.containsKey(product)
        ? product.total - cart.products[product]
        : product.total;
    return ListTile(
      leading: Badge(
        badgeColor: Theme.of(context).primaryColor.withOpacity(0.7),
        padding: EdgeInsets.all(Layouts.SPACING / 2),
        badgeContent: Text(
          cart.products.containsKey(product)
              ? cart.products[product].toString()
              : '',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        position: BadgePosition.topEnd(),
        showBadge: cart.products.containsKey(product) ? true : false,
        child: product.image.isEmpty
            ? Image.asset(Images.IMAGE_HOLDER)
            : Image.network(product.image),
      ),
      title: Text(
        product.name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        'SKU: ' + product.sku,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.7),
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            NumberFormat('#,###').format(product.price),
          ),
          Text(
            '$_total',
            style: TextStyle(
              color: _total <= 0
                  ? Colors.red
                  : Theme.of(context).textTheme.bodyText1.color,
            ),
          ),
        ],
      ),
      onTap: () {
        if (Provider.of<bool>(context, listen: false)) {
          if (cart.products.containsKey(product)) {
            final _selectTotal = cart.products[product];
            if (product.total == _selectTotal) return;
          }
          cart.add(product);
        } else {
          if (cart.products.containsKey(product)) {
            final _selectTotal = cart.products[product];
            if (product.total == _selectTotal) return;
          }
          cart.add(product);
          Navigator.pop(context);
        }
      },
    );
  }
}
