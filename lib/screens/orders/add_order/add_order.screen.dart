import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//Components
import 'components/body.dart';
import 'components/order_actions/create_order_actions.dart';
import 'components/order_actions/new_order_actions.dart';
import 'components/order_actions/confirmed_order_actions.dart';
import 'components/order_actions/sent_order_actions.dart';
import 'components/order_actions/received_order_actions.dart';
import 'components/order_actions/returning_order_actions.dart';

//Models
import 'package:cntt2_crm/models/Cart.dart';
import 'package:cntt2_crm/models/Order/Order.dart';

class FormValidate {
  final customer = GlobalKey<FormState>();
  final stock = GlobalKey<FormState>();
  final address = GlobalKey<FormState>();
  final recipient = GlobalKey<FormState>();
}

class AddOrderScreen extends StatelessWidget {
  final Order order;
  final String conversationId;
  final FormValidate form = FormValidate();
  AddOrderScreen({Key key, this.conversationId, this.order}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _addOrderScreenAppBar(context),
      body: Provider<FormValidate>.value(
        value: form,
        child: Body(),
      ),
      bottomNavigationBar: _OrderButton(form: form),
    );
  }

  AppBar _addOrderScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        order != null ? 'Thông tin đơn hàng' : 'Thêm đơn hàng',
      ),
    );
  }
}

class _OrderButton extends StatelessWidget {
  final FormValidate form;
  const _OrderButton({Key key, @required this.form}) : super(key: key);

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
                      'Tổng tiền',
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
                Provider<FormValidate>.value(
                  value: form,
                  child: _StatusOrderButton(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusOrderButton extends StatefulWidget {
  const _StatusOrderButton({Key key}) : super(key: key);

  @override
  __StatusOrderButtonState createState() => __StatusOrderButtonState();
}

class __StatusOrderButtonState extends State<_StatusOrderButton> {
  int _status;
  @override
  void initState() {
    super.initState();
    _status = Provider.of<Cart>(context, listen: false).initStatus;
  }

  @override
  Widget build(BuildContext context) {
    switch (_status) {
      case 0:
        return CreateOrderActions();
        break;
      case 1:
        return NewOrderActions();
      case 2:
        return ConfirmedOrderActions();
      case 3:
        return SentOrderActions();
      case 4:
        return ReceivedOrderActions();
      case 5:
        return ReturningOrderActions();
      default:
        return Container();
    }
  }
}
