import 'package:flutter/material.dart';

class Address {
  String address;
  String city;
  int cityCode;
  String district;
  int districtCode;
  String ward;
  int wardCode;

  String get fullAddress {
    return address + ', ' + ward + ', ' + district + ', ' + city;
  }

  Address({
    @required this.address,
    this.city,
    @required this.cityCode,
    this.district,
    @required this.districtCode,
    this.ward,
    @required this.wardCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'],
      cityCode: json['city']['_id'],
      city: json['city']['label'],
      districtCode: json['district']['_id'],
      district: json['district']['label'],
      wardCode: json['ward']['_id'],
      ward: json['ward']['label'],
    );
  }
}
