import 'package:cntt2_crm/utilities/datetime.dart';

import 'Address.dart';
import 'package:flutter/material.dart';

class StatusOrder {
  int code;
  String text = '---';
  Color color;

  StatusOrder({@required this.code}) {
    switch (code) {
      case 1:
        text = 'Đặt hàng';
        color = Colors.orange;
        break;
      case 2:
        text = 'Duyệt';
        color = Colors.orange;
        break;
      case 3:
        text = 'Đóng gói';
        color = Colors.purple;
        break;
      case 4:
        text = 'Đang giao hàng';
        color = Colors.blue;
        break;
      case 5:
        text = 'Chờ thanh toán';
        color = Colors.yellow;
        break;
      case 6:
        text = 'Hoàn thành';
        color = Colors.green;
        break;
      default:
    }
  }
}

class Order extends ChangeNotifier {
  final String id;
  final int numberId;
  final String conversationId;
  final String createBy;
  int cod;
  Address address;
  String phone;
  final StatusOrder status;
  final String dateCreated;
  final int timeCreated;

  Order({
    @required this.id,
    @required this.numberId,
    @required this.conversationId,
    @required this.createBy,
    @required this.cod,
    @required this.address,
    this.phone,
    @required this.status,
    @required this.dateCreated,
    @required this.timeCreated,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      numberId: json['id'],
      conversationId: json['conversation_id'],
      createBy: json['created_by_user']['display_name'],
      cod: json['COD'],
      address: Address.fromJson(json),
      phone: json['phone_number'],
      status: new StatusOrder(code: json['status']),
      dateCreated: readTimestampHHDM(json['date_created']),
      timeCreated: json['date_created'],
    );
  }
}
