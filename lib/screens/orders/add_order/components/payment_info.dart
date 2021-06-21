import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:flutter/services.dart';

class PaymentInfo extends StatelessWidget {
  final TextEditingController _discount = TextEditingController();
  final TextEditingController _transfer = TextEditingController();
  final TextEditingController _payment = TextEditingController();
  final TextEditingController _another = TextEditingController();

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
    return Column(
      children: [
        TextField(
          controller: _discount,
          style: Theme.of(context).textTheme.bodyText2,
          keyboardType: TextInputType.number,
          inputFormatters: [
            _currencyFormat,
          ],
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.card_giftcard_rounded),
            filled: false,
            labelText: 'Giảm giá',
          ),
        ),
        SizedBox(height: Layouts.SPACING),
        TextField(
          controller: _transfer,
          style: Theme.of(context).textTheme.bodyText2,
          keyboardType: TextInputType.number,
          inputFormatters: [
            _currencyFormat,
          ],
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.attach_money_rounded),
            filled: false,
            labelText: 'Chuyển khoản',
          ),
        ),
        SizedBox(height: Layouts.SPACING),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: TextField(
                controller: _payment,
                style: Theme.of(context).textTheme.bodyText2,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  _currencyFormat,
                ],
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.payment_rounded),
                  filled: false,
                  labelText: 'Đã quẹt thẻ',
                ),
              ),
            ),
            SizedBox(width: Layouts.SPACING),
            Expanded(
              flex: 1,
              child: TextField(
                controller: _another,
                style: Theme.of(context).textTheme.bodyText2,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  _currencyFormat,
                ],
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.payments_rounded),
                  filled: false,
                  labelText: 'Hình thức khác',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
