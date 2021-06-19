import 'package:cntt2_crm/providers/azsales_api/chat_service/location_api.dart';
import 'package:flutter/material.dart';

import 'District.dart';

class City {
  final int id;
  final String name;
  List<District> _districts;

  City({
    @required this.id,
    @required this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['_id'],
      name: json['label'],
    );
  }

  @override
  String toString() => name;
  @override
  operator ==(o) => o is City && o.id == id;
  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  Future<List<District>> get districts async {
    if (_districts == null) {
      _districts = await LocationAPI.fetchAllDistrict(city: this);
    }
    return _districts;
  }

  District getDistrict(int id) {
    return _districts.firstWhere((district) => district.id == id);
  }
}
