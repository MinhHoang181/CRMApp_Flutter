import 'dart:convert';

import 'package:cntt2_crm/models/AzsalesAccount.dart';
import 'package:flutter_login/flutter_login.dart';

import 'package:http/http.dart' as http;

const azsales_auth_api_url = 'auth-service-dev.azsales.vn';

Future<AzsalesAccount> login(LoginData data) async {
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
    Map<String, dynamic> json =
        jsonDecode(response.body)['data']['auth']['login'];
    return json['accessToken'] == null ? null : AzsalesAccount.fromJson(json);
  } else {
    print(response.body);
    throw Exception('Lỗi đăng nhập');
  }
}
