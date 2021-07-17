import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Components
import 'package:cntt2_crm/screens/components/progress_dialog.dart';

//Models
import 'package:cntt2_crm/models/Cart.dart';

class ReturnButton extends StatelessWidget {
  const ReturnButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Đã trả hàng'),
      onPressed: () {
        final cart = Provider.of<Cart>(context, listen: false);
        showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => ProgressDialog(
            future: cart.returnOrder(),
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
      },
    );
  }
}
