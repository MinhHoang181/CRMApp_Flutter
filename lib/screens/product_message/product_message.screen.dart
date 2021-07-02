import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:provider/provider.dart';

//Models
import 'package:cntt2_crm/models/ProductMessage.dart';

//Components
import 'components/body.dart';

class ProductMessageScreen extends StatelessWidget {
  const ProductMessageScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _productMessageScreenAppBar(context),
      body: Body(),
      bottomSheet: _sendButton(context),
    );
  }

  AppBar _productMessageScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Chọn thông tin sản phẩm'),
    );
  }

  Widget _sendButton(BuildContext context) {
    final productMessage = Provider.of<ProductMessage>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(Layouts.SPACING),
      margin: const EdgeInsets.only(
        bottom: Layouts.SPACING,
      ),
      height: 80,
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(Icons.send_rounded),
        label: Text('Gửi tin nhắn sản phẩm'),
        onPressed: () {
          if (productMessage.product == null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(errorSnackBar('Chưa chọn sản phẩm'));
          } else {
            Navigator.of(context).pop(productMessage);
          }
        },
      ),
    );
  }

  SnackBar errorSnackBar(String text) {
    return SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text(text),
    );
  }
}
