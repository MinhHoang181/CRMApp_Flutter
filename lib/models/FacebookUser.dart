import 'package:flutter/material.dart';

class FacebookUser {
  final String id;
  final String firstName;
  final String lastName;
  final String urlPic;
  String fullName;
  NetworkImage avatar;

  FacebookUser({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.urlPic,
  }) {
    this.avatar = NetworkImage(urlPic);
    this.fullName = lastName + ' ' + firstName;
  }

  factory FacebookUser.fromJson(Map<String, dynamic> json) {
    return FacebookUser(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      urlPic: json['profile_pic'],
    );
  }
}
