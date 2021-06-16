//Models
import 'package:cntt2_crm/models/Address.dart';
import 'package:flutter/material.dart';

class Customer {
  String id;
  final String name;
  String phone;
  String email;
  Address address;
  String birthday;
  String type;

  Customer({
    this.id,
    @required this.name,
    this.phone,
    this.email,
    this.address,
    this.birthday,
    this.type,
  });
}
