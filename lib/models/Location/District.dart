import 'package:cntt2_crm/models/Location/City.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/location_api.dart';
import 'package:flutter/material.dart';

import 'Ward.dart';

class District {
  final int id;
  final String name;
  final City city;
  List<Ward> _wards;

  District({
    @required this.id,
    @required this.name,
    this.city,
  });

  factory District.fromJson(City city, Map<String, dynamic> json) {
    return District(
      id: json['_id'],
      name: json['label'],
      city: city,
    );
  }

  @override
  String toString() => name;
  @override
  operator ==(o) => o is District && o.id == id;
  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  Future<List<Ward>> get wards async {
    if (_wards == null) {
      _wards = await LocationAPI.fetchAllWard(district: this);
    }
    return _wards;
  }
}
