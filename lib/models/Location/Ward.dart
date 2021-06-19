import 'package:cntt2_crm/models/Location/City.dart';
import 'package:cntt2_crm/models/Location/District.dart';
import 'package:flutter/material.dart';

class Ward {
  final int id;
  final String name;
  final District district;
  final City city;

  Ward({
    @required this.id,
    @required this.name,
    @required this.district,
    @required this.city,
  });

  factory Ward.fromJson(District district, Map<String, dynamic> json) {
    return Ward(
      id: json['_id'],
      name: json['label'],
      district: district,
      city: district.city,
    );
  }

  @override
  String toString() => name;
  @override
  operator ==(o) => o is Ward && o.id == id;
  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
