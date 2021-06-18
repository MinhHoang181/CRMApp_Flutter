import 'package:flutter/material.dart';
import 'package:dvhcvn/dvhcvn.dart' as Location;

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
    @required this.cityCode,
    this.district,
    @required this.districtCode,
    this.ward,
    @required this.wardCode,
  }) {
    if (this.city == null && this.cityCode != null) {
      this.city = Location.findLevel1ById(cityCode.toString()).name;
      if (this.district == null && this.districtCode != null) {
        this.district = Location.findLevel1ById(cityCode.toString())
            .findLevel2ById(districtCode.toString())
            .name;
        if (this.ward == null && this.wardCode != null) {
          this.ward = Location.findLevel1ById(cityCode.toString())
              .findLevel2ById(districtCode.toString())
              .findLevel3ById(wardCode.toString())
              .name;
        }
      }
    }
  }

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
  factory Address.fromJsonByCode(Map<String, dynamic> json) {
    return Address(
      address: json['address'],
      cityCode: json['city_code'],
      districtCode: json['district_code'],
      wardCode: json['ward_code'],
    );
  }
}
