//Models
import 'package:cntt2_crm/models/Location/Address.dart';
import 'package:flutter/material.dart';

class Customer extends ChangeNotifier {
  String id;
  final String name;
  String phone;
  Address address;

  Customer({
    @required this.id,
    @required this.name,
    @required this.phone,
    @required this.address,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['customer']['_id'],
      name: json['customer']['customer_name'],
      phone: json['customer']['phone_number'],
      address: Address.fromJson(json),
    );
  }
}
