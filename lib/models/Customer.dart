//Models
import 'package:cntt2_crm/models/Location/Address.dart';
import 'package:flutter/material.dart';

class Customer extends ChangeNotifier {
  String id;
  String name;
  String phone;
  Address address;

  Customer({
    this.id,
    this.name,
    this.phone,
    this.address,
  }) {
    if (address == null) {
      this.address = new Address();
    }
  }

  factory Customer.fromJson(Map<String, dynamic> json, Address address) {
    return Customer(
      id: json['customer']['_id'],
      name: json['customer']['customer_name'],
      phone: json['customer']['phone_number'],
      address: address,
    );
  }

  factory Customer.fromJsonOrder(Map<String, dynamic> json) {
    return json != null
        ? Customer(
            id: json['_id'],
            name: json['customer_name'],
            phone: json['phone_number'],
          )
        : null;
  }

  void copy(Customer customer) {
    this.id = customer.id;
    this.name = customer.name;
    this.phone = customer.phone;
    this.address = customer.address;
  }
}
