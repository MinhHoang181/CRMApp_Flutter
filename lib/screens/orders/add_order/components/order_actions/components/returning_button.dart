import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Components
import 'package:cntt2_crm/screens/components/progress_dialog.dart';

//Models
import 'package:cntt2_crm/models/Cart.dart';

class ReturningButton extends StatelessWidget {
  const ReturningButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Trả hàng'),
      onPressed: () {
        final cart = Provider.of<Cart>(context, listen: false);
        showDialog(
          context: context,
          builder: (context) => _alertDialog(context),
        ).then((value) {
          if (value != null && value) {
            showDialog<bool>(
              context: context,
              barrierDismissible: false,
              builder: (context) => ProgressDialog(
                future: cart.returningOrder(),
                loading: 'Đang cập nhật đơn hàng',
                success: 'Cập nhật đơn hàng thành công',
                falied: 'Cập nhật đơn hàng thất bại',
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
      title: Text('Xác nhận trả hàng'),
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
