import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Components
import 'package:cntt2_crm/screens/components/progress_dialog.dart';

//Models
import 'package:cntt2_crm/models/Cart.dart';
import 'package:cntt2_crm/screens/orders/add_order/add_order.screen.dart';

class EditButton extends StatelessWidget {
  const EditButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Sửa đơn hàng'),
      onPressed: () {
        final form = Provider.of<FormValidate>(context, listen: false);
        final customer = form.customer.currentState.validate();
        final stock = form.stock.currentState.validate();
        final address = form.address.currentState != null
            ? form.address.currentState.validate()
            : true;
        final recipient = form.recipient.currentState != null
            ? form.recipient.currentState.validate()
            : true;
        final product =
            Provider.of<Cart>(context, listen: false).products.isEmpty
                ? false
                : true;

        if (customer && stock && address && recipient && product) {
          final cart = Provider.of<Cart>(context, listen: false);
          showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (context) => ProgressDialog(
              future: cart.updateOrder(),
              loading: 'Đang sửa đơn hàng',
              success: 'Sửa đơn hàng thành công',
              falied: 'Sửa đơn hàng thất bại',
            ),
          );
        } else {
          if (!customer) {
            ScaffoldMessenger.of(context)
                .showSnackBar(errorSnackBar('Chưa nhập thông tin khách hàng'));
          } else if (!address) {
            ScaffoldMessenger.of(context)
                .showSnackBar(errorSnackBar('Chưa nhập địa chỉ'));
          } else if (!stock) {
            ScaffoldMessenger.of(context)
                .showSnackBar(errorSnackBar('Chưa chọn kho'));
          } else if (!recipient) {
            ScaffoldMessenger.of(context)
                .showSnackBar(errorSnackBar('Chưa nhập thông tin người nhận'));
          } else if (!product) {
            ScaffoldMessenger.of(context)
                .showSnackBar(errorSnackBar('Chưa có sản phẩm'));
          }
        }
      },
    );
  }

  SnackBar errorSnackBar(String text) {
    return SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text(text),
    );
  }
}
