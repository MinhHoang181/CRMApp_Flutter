import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

//Models
import 'package:cntt2_crm/models/FacebookUser.dart';
import 'package:cntt2_crm/models/Conversation.dart';

const String access_token =
    'EAAEltaK2YYoBALnS1GrbGadbsFbBo4Fr6TbaSBi9PpaSL2wGl90A50eIL8L1KqmeaSbPuOUm4r7yPR9KDQdXd0ZCS8YdKIdvLZB4wQse34wKTUOoQ3mb8t9IVX38eP1kSW1u2ACPIZAvCcgJr5FwmZBJ6P3EYW56UvSTbRpssD2M4gaCLNADL3LV4gnQRfAyRKkxZAU4RwI8sLZAb0qGroZCeFnd6A2C8gZD';

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
  final String messagesField = 'messages.limit(1){tags,from,to}';
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
