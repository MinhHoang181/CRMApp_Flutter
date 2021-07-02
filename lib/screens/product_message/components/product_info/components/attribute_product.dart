import 'package:cntt2_crm/models/list_model/VariantList.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/ProductMessage.dart';
import 'package:cntt2_crm/models/Product/Variant.dart';

class AttributeProduct extends StatelessWidget {
  const AttributeProduct({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasAttribute = context
        .select((ProductMessage productMessage) => productMessage.hasAttribute);
    return hasAttribute ? _futureBuilder(context) : Container();
  }

  Widget _futureBuilder(BuildContext context) {
    final product = context
        .select((ProductMessage productMessage) => productMessage.product);
    return FutureBuilder(
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
    );
  }

  Widget _listVariant(BuildContext context, VariantList variantList) {
    return variantList.map.isNotEmpty
        ? Column(
            children: List.generate(
              variantList.map.length,
              (index) => _VariantItem(
                variant: variantList.map.values.elementAt(index),
              ),
            )..addAll(
                [
                  SizedBox(height: 100),
                ],
              ),
          )
        : Container(
            height: 50,
            child: Center(
              child: Text('Sản phẩm không có thuộc tính'),
            ),
          );
  }
}

class _VariantItem extends StatefulWidget {
  final Variant variant;
  const _VariantItem({Key key, @required this.variant}) : super(key: key);

  @override
  __VariantItemState createState() => __VariantItemState();
}

class __VariantItemState extends State<_VariantItem> {
  ProductMessage _productMessage;
  @override
  void initState() {
    super.initState();

    _productMessage = Provider.of<ProductMessage>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(Layouts.SPACING / 2),
          child: Row(
            children: [
              Text(widget.variant.barcode),
              SizedBox(width: Layouts.SPACING),
              Expanded(child: Text(widget.variant.attributesToString())),
              _PriceVariant(price: widget.variant.finalPrice),
              Checkbox(
                value: _productMessage.containVariant(widget.variant),
                onChanged: (_) => _changeCheck(),
              ),
            ],
          ),
        ),
      ),
      onTap: _changeCheck,
    );
  }

  void _changeCheck() {
    final value = !_productMessage.containVariant(widget.variant);
    setState(() {
      if (value) {
        _productMessage.addVariant(widget.variant);
      } else {
        _productMessage.removeVariant(widget.variant);
      }
    });
  }
}

class _PriceVariant extends StatelessWidget {
  final double price;
  const _PriceVariant({Key key, @required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasPrice = context
        .select((ProductMessage productMessage) => productMessage.hasPrice);
    return hasPrice ? _price(context) : Container();
  }

  Widget _price(BuildContext context) {
    return Text(
      NumberFormat('#,### đ').format(price),
    );
  }
}
