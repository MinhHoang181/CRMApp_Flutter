import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Components
import 'package:cntt2_crm/screens/components/progress_dialog.dart';

//Models
import 'package:cntt2_crm/models/Cart.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Duyệt đơn hàng'),
      onPressed: () {
        final cart = Provider.of<Cart>(context, listen: false);
        showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => ProgressDialog(
            future: cart.confirmOrder(),
            loading: 'Đang duyệt đơn hàng',
            success: 'Duyệt đơn hàng thành công',
            falied: 'Duyệt đơn hàng thất bại',
          ),
        ).then((value) {
          if (value != null) {
            if (value) {
              Navigator.of(context).pop();
            }
          }
        });
      },
    );
  }
}
