import 'package:cntt2_crm/models/Azsales/AzsalesAccount.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:graphql/client.dart';

GraphQLClient _getAuthClient() {
  final Link _link = HttpLink('https://auth-service-dev.azsales.vn/graphql');
  return GraphQLClient(
    link: _link,
    cache: GraphQLCache(),
  );
}

Future<AzsalesAccount> login(LoginData data) async {
  final _name = data.name;
  final _password = data.password;

  final GraphQLClient _client = _getAuthClient();

  final QueryOptions options = QueryOptions(
    document: gql(
      '''
        query {
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
      ''',
    ),
  );

  final response = await _client.query(options);
  if (response.hasException) {
    print(response.exception.toString());
    throw Exception('Lỗi đăng nhập');
  }
  Map<String, dynamic> json = response.data['auth']['login'];
  return json['accessToken'] == null ? null : AzsalesAccount.fromJson(json);
}
