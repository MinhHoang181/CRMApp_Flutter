import 'package:flutter/material.dart';

class StatusOrder {
  final int code;
  final String text;
  final Color color;

  const StatusOrder({
    @required this.code,
    @required this.text,
    @required this.color,
  });

  static StatusOrder get newOrder => const StatusOrder(
        code: 1,
        text: 'Mới',
        color: Colors.pinkAccent,
      );
  static StatusOrder get confirmedOrder => const StatusOrder(
        code: 2,
        text: 'Đã xác nhận',
        color: Colors.lightBlueAccent,
      );
  static StatusOrder get sentOrder => const StatusOrder(
        code: 3,
        text: 'Đã gửi hàng',
        color: Colors.purple,
      );
  static StatusOrder get doneOrder => const StatusOrder(
        code: 4,
        text: 'Đã nhận hàng',
        color: Colors.green,
      );
  static StatusOrder get returningOrder => const StatusOrder(
        code: 5,
        text: 'Đang trả hàng',
        color: Colors.orange,
      );
  static StatusOrder get returnedOrder => const StatusOrder(
        code: 6,
        text: 'Đã trả hàng',
        color: Colors.red,
      );
  static StatusOrder get cancelOrder => const StatusOrder(
        code: 7,
        text: 'Đã hủy',
        color: Colors.black,
      );

  static StatusOrder fromCode({@required int code}) {
    switch (code) {
      case 1:
        return newOrder;
      case 2:
        return confirmedOrder;
      case 3:
        return sentOrder;
      case 4:
        return doneOrder;
      case 5:
        return returningOrder;
      case 6:
        return returnedOrder;
      case 7:
        return cancelOrder;
      default:
        return const StatusOrder(
          code: 0,
          text: '---',
          color: Colors.black,
        );
    }
  }
}
