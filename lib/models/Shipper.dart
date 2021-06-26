import 'package:cntt2_crm/models/Transport.dart';
import 'package:flutter/material.dart';

class Shipper {
  final String id;
  final String name;
  final String description;
  final String urlLogo;
  final bool isActive;
  final List<Transport> transports;

  Shipper({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.urlLogo,
    @required this.isActive,
    @required this.transports,
  });

  factory Shipper.fromJson(Map<String, dynamic> json) {
    List<dynamic> transportsJson = json['transports'];
    List<Transport> transports = List.empty(growable: true);
    transportsJson.forEach((transport) {
      transports.add(Transport.fromJson(transport));
    });
    return Shipper(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      urlLogo: json['logo'],
      isActive: json['is_active'],
      transports: transports,
    );
  }
}
