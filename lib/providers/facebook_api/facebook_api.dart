import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

//Models
import 'package:cntt2_crm/models/FacebookUser.dart';
import 'package:cntt2_crm/models/Conversation.dart';

const String access_token =
    'EAACrQDFJsh4BADBdV9iiPVJ0S0cXQeqLTynl5i1JrsmA7pZC0Q9gNCftZB0u7MThdqprHmj0ZB0bTAD724d0YNYsFRjSIF4J11IZAUNui7ZCcZAGi7OXDh9BTxk3IWGusFPQH7JOll7RpZBnKhiCZAdlM3EJEATkz2HwdogTkXeODmSkBz2KQHNe8ZCh7ZBQ3tSPZBYVbii6cbFkgZDZD';

const String facebook_api_uri = 'graph.facebook.com';
const String version = 'v10.0';

Future<FacebookUser> fetchFacebookUser(String userId) async {
  final String unencodePath = version + '/' + userId;
  final response = await http.get(Uri.https(facebook_api_uri, unencodePath, {
    'access_token': access_token,
  }));

  if (response.statusCode == 200) {
    return FacebookUser.fromJson(jsonDecode(response.body));
  } else {
    print(response.body);
    throw Exception('Lỗi load thông tin người dùng Facebook');
  }
}

Future<Conversations> fetchConversations(String pageId) async {
  final String messagesField = 'messages.limit(1){tags}';
  final String fields =
      'snippet,unread_count,updated_time,participants' + ',' + messagesField;

  final String unencodePath = version + '/' + pageId + '/' + 'conversations';
  final response = await http.get(Uri.https(facebook_api_uri, unencodePath, {
    'fields': fields,
    'access_token': access_token,
  }));

  if (response.statusCode == 200) {
    return Conversations.fromJson(pageId, jsonDecode(response.body)['data']);
  } else {
    print(response.body);
    throw Exception('Lỗi load thông tin danh sách tin nhắn');
  }
}
