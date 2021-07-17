import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Components
import 'package:cntt2_crm/screens/components/progress_dialog.dart';

//Models
import 'package:cntt2_crm/models/Cart.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Hủy đơn hàng'),
      onPressed: () {
        final cart = Provider.of<Cart>(context, listen: false);
        showDialog<bool>(
          context: context,
          builder: (context) => _alertDialog(context),
        ).then((value) {
          if (value != null && value) {
            showDialog<bool>(
              context: context,
              barrierDismissible: false,
              builder: (context) => ProgressDialog(
                future: cart.cancelOrder(),
                loading: 'Đang hủy đơn hàng',
                success: 'Hủy đơn hàng thành công',
                falied: 'Hủy đơn hàng thất bại',
              ),
            ).then((value) {
              if (value != null) {
                if (value) {
                  Navigator.of(context).pop();
                }
              }
            });
          }
        });
      },
    );
  }

  Widget _alertDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Xác nhận hủy đơn hàng'),
      actions: [
        TextButton(
          child: Text('Hủy'),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        TextButton(
          child: Text(
            'Xác nhận',
          ),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}
