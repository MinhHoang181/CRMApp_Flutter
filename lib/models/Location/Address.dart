import 'package:flutter/material.dart';

class Address {
  String address;
  String city;
  int cityCode;
  String district;
  int districtCode;
  String ward;
  int wardCode;

  bool get hasAddress =>
      cityCode != null &&
      districtCode != null &&
      wardCode != null &&
      address != null;

  String get fullAddress {
    if (city == null || district == null || ward == null) {
      return null;
    }
    return address + ', ' + ward + ', ' + district + ', ' + city;
  }

  Address({
    @required this.address,
    this.city,
    this.cityCode,
    this.district,
    this.districtCode,
    this.ward,
    this.wardCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'],
      cityCode: json['city'] != null ? json['city']['_id'] : null,
      city: json['city'] != null ? json['city']['label'] : null,
      districtCode: json['district'] != null ? json['district']['_id'] : null,
      district: json['district'] != null ? json['district']['label'] : null,
      wardCode: json['ward'] != null ? json['ward']['_id'] : null,
      ward: json['ward'] != null ? json['ward']['label'] : null,
    );
  }
}
