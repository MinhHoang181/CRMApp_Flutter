import 'package:flutter/material.dart';

class TypeOrder {
  final int code;
  String _text;
  String get text => _text;
  IconData _icon;
  IconData get icon => _icon;

  TypeOrder({@required this.code}) {
    switch (code) {
      case 1:
        this._text = 'Bán tại shop';
        this._icon = Icons.shopping_basket_outlined;
        break;
      case 2:
        this._text = 'Giao hàng thu hộ';
        this._icon = Icons.local_shipping_outlined;
        break;
      case 3:
        this._text = 'Giao hàng ứng tiền';
        this._icon = Icons.payment_outlined;
        break;
      default:
        this._text = '---';
        this._icon = Icons.error_rounded;
    }
  }
}
