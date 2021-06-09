import 'package:cntt2_crm/models/PageFacebook.dart';

class User {
  String displayName;
  String username;
  String email;
  String role;
  String accessToken;
  List<PageFacebook> pages;

  User({
    this.displayName,
    this.username,
    this.role,
    this.email,
    this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> userData = json['userData'];
    return User(
      displayName: userData == null ? null : userData['display_name'],
      username: userData == null ? null : userData['username'],
      role: userData == null ? null : userData['user_role'],
      email: userData == null ? null : userData['email'],
      accessToken: json['accessToken'],
    );
  }
}
