import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Models
import 'package:cntt2_crm/models/ProductMessage.dart';
import 'package:cntt2_crm/components/image_item.dart';
import 'package:cntt2_crm/models/Product/Photo.dart';

class PhotoProduct extends StatelessWidget {
  const PhotoProduct({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasPhoto = context
        .select((ProductMessage productMessage) => productMessage.hasPhoto);
    return hasPhoto ? _listPhoto(context) : Container();
  }

  Widget _listPhoto(BuildContext context) {
    final product = context
        .select((ProductMessage productMessage) => productMessage.product);
    return product.photos.isNotEmpty
        ? GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(
              product.photos.length,
              (index) => _PhotoCheckbox(
                photo: product.photos[index],
              ),
            ),
          )
        : Container(
            height: 50,
            child: Center(
              child: Text('Sản phẩm không có ảnh'),
            ),
          );
  }
}

class _PhotoCheckbox extends StatefulWidget {
  final Photo photo;
  const _PhotoCheckbox({Key key, @required this.photo}) : super(key: key);

  @override
  _PhotoCheckboxState createState() => _PhotoCheckboxState();
}

class _PhotoCheckboxState extends State<_PhotoCheckbox> {
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
        child: Column(
          children: [
            FittedBox(
              child: ImageItem(
                url: widget.photo.url,
                size: const Size(100, 100),
              ),
            ),
            Flexible(
              child: Checkbox(
                value: _productMessage.containPhoto(widget.photo),
                onChanged: (_) => _changeCheck(),
              ),
            )
          ],
        ),
      ),
      onTap: _changeCheck,
    );
  }

  void _changeCheck() {
    setState(() {
      final value = !_productMessage.containPhoto(widget.photo);
      if (value) {
        _productMessage.addPhoto(widget.photo);
      } else {
        _productMessage.removePhoto(widget.photo);
      }
    });
  }
}
