import 'dart:convert';

import 'package:cntt2_crm/models/User.dart';
import 'package:flutter_login/flutter_login.dart';

import 'package:http/http.dart' as http;

const azsales_auth_api_url = 'auth-service-dev.azsales.vn';

Future<User> login(LoginData data) async {
  final _name = data.name;
  final _password = data.password;
  final String unencodedPath = 'graphql';
  final String query = """
    {
      auth {
        login(username: "$_name", password: "$_password") {
          accessToken,
          userData {
            username,
            display_name,
            user_role,
            email,
          }
          error {
            message,
          }
        }
      }
    }
  """;
  final response = await http.get(Uri.https(
    azsales_auth_api_url,
    unencodedPath,
    {
      'query': query,
    },
  ));

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body)['data']['auth']['login']);
  } else {
    print(response.body);
    throw Exception('Lỗi đăng nhập');
  }
}
