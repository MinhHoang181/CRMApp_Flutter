//Models
import 'package:flutter/material.dart';

import 'Label.dart';

class Address {
  int provinceId;
  String province;
  int districtId;
  String district;
  int wardId;
  String ward;
  String address;

  Address({
    @required this.province,
    @required this.district,
    @required this.ward,
    @required this.address,
  });

  @override
  String toString() {
    String address = this.address +
        ', ' +
        this.ward +
        ', ' +
        this.district +
        ', ' +
        this.province;
    return address;
  }
}

class Customer {
  String id;
  final String name;
  String phone;
  String email;
  Address address;
  String birthday;
  String type;

  List<Label> labels = List.empty(growable: true);

  Customer({
    this.id,
    @required this.name,
    this.phone,
    this.email,
    this.address,
    this.birthday,
    this.type,
  });

  void addLabel(Label label) {
    if (!labels.contains(label)) {
      labels.add(label);
    }
  }

  void removeLabel(Label label) {
    if (labels.contains(label)) {
      labels.remove(label);
    }
  }
}
