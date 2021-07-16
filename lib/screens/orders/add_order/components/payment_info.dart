import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

//Models
import 'package:cntt2_crm/models/Cart.dart';

class PaymentInfo extends StatelessWidget {
  final CurrencyTextInputFormatter _currencyFormat = CurrencyTextInputFormatter(
    decimalDigits: 0,
    customPattern: '#,### đ',
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Layouts.SPACING),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context),
          SizedBox(height: Layouts.SPACING),
          _body(context),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Text(
      'Thông tin thanh toán',
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  Widget _body(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final canEdit = context.select((Cart cart) => cart.canEdit);
    return Column(
      children: [
        TextField(
          enabled: canEdit,
          style: Theme.of(context).textTheme.bodyText2,
          keyboardType: TextInputType.number,
          inputFormatters: [
            _currencyFormat,
          ],
          controller: cart.discount != 0
              ? TextEditingController(text: cart.discount.toString())
              : null,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.card_giftcard_rounded),
            filled: false,
            labelText: 'Giảm giá',
            hintText: '0',
          ),
          onChanged: (value) {
            cart.discount = _toValue(value);
          },
        ),
        SizedBox(height: Layouts.SPACING),
        TextField(
          enabled: canEdit,
          style: Theme.of(context).textTheme.bodyText2,
          keyboardType: TextInputType.number,
          inputFormatters: [
            _currencyFormat,
          ],
          controller: cart.bank != 0
              ? TextEditingController(text: cart.bank.toString())
              : null,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.attach_money_rounded),
            filled: false,
            labelText: 'Chuyển khoản',
            hintText: '0',
          ),
          onChanged: (value) {
            cart.bank = _toValue(value);
          },
        ),
        SizedBox(height: Layouts.SPACING),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: TextField(
                enabled: canEdit,
                style: Theme.of(context).textTheme.bodyText2,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  _currencyFormat,
                ],
                controller: cart.card != 0
                    ? TextEditingController(text: cart.card.toString())
                    : null,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.payment_rounded),
                  filled: false,
                  labelText: 'Đã quẹt thẻ',
                  hintText: '0',
                ),
                onChanged: (value) {
                  cart.card = _toValue(value);
                },
              ),
            ),
            SizedBox(width: Layouts.SPACING),
            Expanded(
              flex: 1,
              child: TextField(
                enabled: canEdit,
                style: Theme.of(context).textTheme.bodyText2,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  _currencyFormat,
                ],
                controller: cart.other != 0
                    ? TextEditingController(text: cart.other.toString())
                    : null,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.payments_rounded),
                  filled: false,
                  labelText: 'Hình thức khác',
                  hintText: '0',
                ),
                onChanged: (value) {
                  cart.other = _toValue(value);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  int _toValue(String value) {
    value = value.replaceAll(' ', '').replaceAll('đ', '').replaceAll(',', '');
    final int number = value.isEmpty ? 0 : int.parse(value);
    return number != null ? number : 0;
  }
}
