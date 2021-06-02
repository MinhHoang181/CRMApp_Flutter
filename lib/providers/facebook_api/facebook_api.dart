import 'dart:async';
import 'dart:convert';
import 'package:cntt2_crm/models/ChatMessage.dart';
import 'package:http/http.dart' as http;

//Models
import 'package:cntt2_crm/models/Conversation.dart';

const String access_token =
    'EAACrQDFJsh4BADBdV9iiPVJ0S0cXQeqLTynl5i1JrsmA7pZC0Q9gNCftZB0u7MThdqprHmj0ZB0bTAD724d0YNYsFRjSIF4J11IZAUNui7ZCcZAGi7OXDh9BTxk3IWGusFPQH7JOll7RpZBnKhiCZAdlM3EJEATkz2HwdogTkXeODmSkBz2KQHNe8ZCh7ZBQ3tSPZBYVbii6cbFkgZDZD';

const String facebook_api_uri = 'graph.facebook.com';
const String version = 'v10.0';

Future<ConversationModel> fetchConversations(String pageId) async {
  final String messagesField = 'messages.limit(1){tags}';
  final String fields =
      'snippet,unread_count,updated_time,participants' + ',' + messagesField;

  final String unencodedPath = version + '/' + pageId + '/' + 'conversations';
  final response = await http.get(Uri.https(
    facebook_api_uri,
    unencodedPath,
    {
      'fields': fields,
      'access_token': access_token,
    },
  ));

  if (response.statusCode == 200) {
    return ConversationModel.fromJson(
        pageId, jsonDecode(response.body)['data']);
  } else {
    print(response.body);
    throw Exception('Lỗi load thông tin danh sách tin nhắn');
  }
}

Future<Messages> fetchConversation(String conversationId) async {
  final String fields = 'message,tags,created_time,sticker,attachments';
  final String unencodedPath =
      version + '/' + conversationId + '/' + 'messages';
  final response = await http.get(Uri.https(
    facebook_api_uri,
    unencodedPath,
    {
      'fields': fields,
      'access_token': access_token,
    },
  ));

  if (response.statusCode == 200) {
    Messages chatlog = new Messages();
    jsonDecode(response.body)['data'].forEach((element) {
      chatlog.add(ChatMessage.fromJson(element));
    });
    return chatlog;
  } else {
    print(response.body);
    throw Exception('Lỗi load thông tin tin nhắn');
  }
}
