import 'package:cntt2_crm/utilities/datetime.dart';

import 'Address.dart';
import 'package:flutter/material.dart';

class Order extends ChangeNotifier {
  final String id;
  final int numberId;
  final String conversationId;
  final String createBy;
  int cod;
  Address address;
  String phone;
  int status;
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
      status: json['status'],
      dateCreated: readTimestampHHDM(json['date_created']),
      timeCreated: json['date_created'],
    );
  }
}
