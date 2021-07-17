import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  const SendButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Vận chuyển đơn hàng'),
      onPressed: null,
      // onPressed: () {
      //   final cart = Provider.of<Cart>(context, listen: false);
      //   showDialog<bool>(
      //     context: context,
      //     barrierDismissible: false,
      //     builder: (context) => ProgressDialog(
      //       future: cart.confirmOrder(),
      //       loading: 'Đang cập nhật đơn hàng',
      //       success: 'Cập nhật đơn hàng thành công',
      //       falied: 'Cập nhật đơn hàng thất bại',
      //     ),
      //   ).then((value) {
      //     if (value != null) {
      //       if (value) {
      //         Navigator.of(context).pop();
      //       }
      //     }
      //   });
      // },
    );
  }
}
