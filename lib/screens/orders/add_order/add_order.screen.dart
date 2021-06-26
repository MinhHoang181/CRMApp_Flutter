import 'package:cntt2_crm/components/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//Components
import 'components/body.dart';

//Models
import 'package:cntt2_crm/models/Cart.dart';

class FormValidate {
  final customer = GlobalKey<FormState>();
  final stock = GlobalKey<FormState>();
  final address = GlobalKey<FormState>();
  final recipient = GlobalKey<FormState>();
}

class AddOrderScreen extends StatelessWidget {
  final String conversationId;
  final FormValidate form = new FormValidate();
  AddOrderScreen({Key key, this.conversationId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _addOrderScreenAppBar(context),
      body: Provider<FormValidate>.value(
        value: form,
        child: Body(),
      ),
      bottomNavigationBar: CreateOrderButton(form: form),
    );
  }

  AppBar _addOrderScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Thêm đơn hàng'),
    );
  }
}

class CreateOrderButton extends StatelessWidget {
  final FormValidate form;
  const CreateOrderButton({Key key, @required this.form}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _createOrderButton(context);
  }

  BottomAppBar _createOrderButton(BuildContext context) {
    final total = context.select((Cart cart) => cart.totalCost);
    return BottomAppBar(
      child: Container(
        padding: EdgeInsets.all(Layouts.SPACING),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).shadowColor,
                offset: Offset(0, -2),
                blurRadius: 2),
          ],
        ),
        child: Table(
          children: [
            TableRow(
              children: [
                Row(
                  children: [
                    Text(
                      'Tạm tính',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Fonts.SIZE_TEXT_LARGE,
                      ),
                    ),
                    Spacer(),
                    Text(
                      NumberFormat('#,###').format(total) + ' đ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Fonts.SIZE_TEXT_LARGE,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            TableRow(
              children: [
                ElevatedButton(
                  child: Text('Tạo đơn hàng'),
                  onPressed: () {
                    final customer = form.customer.currentState.validate();
                    final stock = form.stock.currentState.validate();
                    final address = form.address.currentState != null
                        ? form.address.currentState.validate()
                        : true;
                    final recipient = form.recipient.currentState != null
                        ? form.recipient.currentState.validate()
                        : true;
                    final product = Provider.of<Cart>(context, listen: false)
                            .products
                            .isEmpty
                        ? false
                        : true;

                    if (customer && stock && address && recipient && product) {
                      final cart = Provider.of<Cart>(context, listen: false);
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
                        ScaffoldMessenger.of(context).showSnackBar(
                            errorSnackBar('Chưa nhập thông tin khách hàng'));
                      } else if (!address) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(errorSnackBar('Chưa nhập địa chỉ'));
                      } else if (!stock) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(errorSnackBar('Chưa chọn kho'));
                      } else if (!recipient) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            errorSnackBar('Chưa nhập thông tin người nhận'));
                      } else if (!product) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(errorSnackBar('Chưa có sản phẩm'));
                      }
                    }
                  },
                ),
              ],
            ),
          ],
        ),
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
