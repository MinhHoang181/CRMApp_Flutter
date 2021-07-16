import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/Cart.dart';
import 'package:cntt2_crm/screens/orders/add_order/add_order.screen.dart';

//Components
import 'package:cntt2_crm/screens/components/progress_dialog.dart';

class CreateOrderButton extends StatefulWidget {
  const CreateOrderButton({Key key}) : super(key: key);

  @override
  _CreateOrderButtonState createState() => _CreateOrderButtonState();
}

class _CreateOrderButtonState extends State<CreateOrderButton> {
  Widget _button;
  @override
  void initState() {
    super.initState();
    _button = _createButton();
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

  Widget _createButton() {
    return ElevatedButton(
      child: Text('Tạo đơn hàng'),
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
          cart.initStatus = 1;
          showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (context) => ProgressDialog(
              future: cart.createOrder(),
              loading: 'Đang tạo đơn hàng',
              success: 'Tạo đơn hàng thành công',
              falied: 'Tạo đơn hàng thất bại',
            ),
          ).then((value) {
            if (value != null) {
              if (value) {
                Navigator.of(context).pop();
              }
            }
          });
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

  Widget _createAndConfirmButton() {
    return ElevatedButton(
      child: Text('Tạo và duyệt đơn hàng'),
      onPressed: () {
        final form = context.watch<FormValidate>();
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
          cart.initStatus = 2;
          showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (context) => ProgressDialog(
              future: cart.createOrder(),
              loading: 'Đang tạo đơn hàng',
              success: 'Tạo đơn hàng thành công',
              falied: 'Tạo đơn hàng thất bại',
            ),
          ).then((value) {
            if (value != null) {
              if (value) {
                Navigator.of(context).pop();
              }
            }
          });
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
            if (value == 1) _button = _createButton();
            if (value == 2) _button = _createAndConfirmButton();
            setState(() {});
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
                  Icon(Icons.create_rounded),
                  SizedBox(
                    width: Layouts.SPACING,
                  ),
                  Text(
                    'Tạo đơn hàng',
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
                  Icon(Icons.check),
                  SizedBox(
                    width: Layouts.SPACING,
                  ),
                  Text(
                    'Tạo và duyệt đơn hàng',
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
        ],
      ),
    );
  }
}
