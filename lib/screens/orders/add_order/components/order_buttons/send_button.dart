import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/Cart.dart';
import 'package:cntt2_crm/screens/orders/add_order/add_order.screen.dart';

//Components
import 'package:cntt2_crm/screens/components/progress_dialog.dart';

class SentOrderButton extends StatefulWidget {
  const SentOrderButton({Key key}) : super(key: key);

  @override
  _SentOrderButtonState createState() => _SentOrderButtonState();
}

class _SentOrderButtonState extends State<SentOrderButton> {
  Widget _button;
  @override
  void initState() {
    super.initState();
    _button = _sendButton();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _button,
        ),
        SizedBox(
          width: Layouts.SPACING,
        ),
        _actionButton(),
      ],
    );
  }

  Widget _sendButton() {
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

  Widget _cancelButton() {
    return ElevatedButton(
      child: Text('Hủy đơn hàng'),
      onPressed: () {
        final cart = Provider.of<Cart>(context, listen: false);
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
      },
    );
  }

  Widget _editButton() {
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

  Widget _actionButton() {
    final cart = Provider.of<Cart>(context, listen: false);
    bool canEdit = false;
    return IconButton(
      icon: Icon(Icons.more_vert_rounded),
      onPressed: () {
        showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          context: context,
          builder: (_) => _listAction(),
        ).then((value) {
          if (value != null) {
            if (value == 1) _button = _sendButton();
            if (value == 2) {
              _button = _editButton();
              canEdit = true;
            }
            if (value == 3) _button = _cancelButton();
            setState(() {
              cart.canEdit = canEdit;
            });
          }
        });
      },
    );
  }

  Widget _listAction() {
    return Container(
      padding: const EdgeInsets.only(
        top: Layouts.SPACING / 2,
        bottom: Layouts.SPACING * 2,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(Layouts.SPACING),
              child: Row(
                children: [
                  Icon(Icons.delivery_dining_rounded),
                  SizedBox(
                    width: Layouts.SPACING,
                  ),
                  Text(
                    'Vận chuyển đơn hàng',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize:
                              Theme.of(context).textTheme.bodyText2.fontSize +
                                  2,
                        ),
                  ),
                ],
              ),
            ),
            onTap: () => Navigator.of(context).pop(1),
          ),
          Divider(),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(Layouts.SPACING),
              child: Row(
                children: [
                  Icon(Icons.edit_rounded),
                  SizedBox(
                    width: Layouts.SPACING,
                  ),
                  Text(
                    'Sửa đơn hàng',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize:
                              Theme.of(context).textTheme.bodyText2.fontSize +
                                  2,
                        ),
                  ),
                ],
              ),
            ),
            onTap: () => Navigator.of(context).pop(2),
          ),
          Divider(),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(Layouts.SPACING),
              child: Row(
                children: [
                  Icon(Icons.delete_rounded),
                  SizedBox(
                    width: Layouts.SPACING,
                  ),
                  Text(
                    'Hủy đơn hàng',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize:
                              Theme.of(context).textTheme.bodyText2.fontSize +
                                  2,
                        ),
                  ),
                ],
              ),
            ),
            onTap: () => Navigator.of(context).pop(3),
          ),
          Divider(),
        ],
      ),
    );
  }
}
