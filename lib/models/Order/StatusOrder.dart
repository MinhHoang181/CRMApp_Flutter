import 'package:flutter/material.dart';

class StatusOrder {
  int code;
  String _text;
  String get text => _text;
  Color _color;
  Color get color => _color;

  StatusOrder({@required this.code}) {
    switch (code) {
      case 1:
        this._text = 'Mới';
        this._color = Colors.pinkAccent;
        break;
      case 2:
        this._text = 'Đã xác nhận';
        this._color = Colors.lightBlueAccent;
        break;
      case 3:
        this._text = 'Đã gửi hàng';
        this._color = Colors.purple;
        break;
      case 4:
        this._text = 'Đã nhận hàng';
        this._color = Colors.green;
        break;
      case 5:
        this._text = 'Đang trả hàng';
        this._color = Colors.orange;
        break;
      case 6:
        this._text = 'Đã trả hàng';
        this._color = Colors.red;
        break;
      default:
        this._text = '---';
        this._color = Colors.black;
    }
  }
}
