//Models
import 'package:flutter/material.dart';

import 'Tag.dart';

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

  List<Tag> tags = List.empty(growable: true);

  Customer({
    this.id,
    @required this.name,
    this.phone,
    this.email,
    this.address,
    this.birthday,
    this.type,
  });

  void addTag(Tag tag) {
    if (!tags.contains(tag)) {
      tags.add(tag);
    }
  }

  void removeTag(Tag tag) {
    if (tags.contains(tag)) {
      tags.remove(tag);
    }
  }
}
