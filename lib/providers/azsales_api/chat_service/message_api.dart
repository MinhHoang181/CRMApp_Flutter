import 'package:cntt2_crm/models/ChatMessage.dart';
import 'package:cntt2_crm/models/PagingInfo.dart';
import 'package:cntt2_crm/providers/azsales_api/url_api.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:tuple/tuple.dart';

class MessageAPI {
  static Future<Tuple2<List<ChatMessage>, PagingInfo>> fetchMessages({
    @required String pageId,
    @required String conversationId,
    int start = 0,
  }) async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          message {
            messagesPaging(
              start: $start
              min: 20
              filter: { conversation_id: "$conversationId" }
            ) {
              pageInfo {
                hasNextPage
                next
                start
                min
              }
              items {
                _id
                message
                from {
                  _id
                }
                created_time
                attachments {
                  _id
                  mime_type
                  name
                  image_data {
                    url
                    preview_url
                    image_type
                    render_as_sticker
                  }
                }
              }
            }
          }
        }
      ''',
      ),
    );
    final GraphQLClient client = getChatClient();
    final response = await client.query(options);
    if (response.hasException) {
      print(response.exception.toString());
      return null;
    } else {
      List<ChatMessage> messages = List.empty(growable: true);
      List<dynamic> messagesJson =
          response.data['message']['messagesPaging']['items'];
      messagesJson.forEach((message) {
        messages.add(ChatMessage.fromJson(message, pageId));
      });
      Map<String, dynamic> pageInfo =
          response.data['message']['messagesPaging']['pageInfo'];
      return Tuple2(messages, PagingInfo.fromJson(pageInfo));
    }
  }
}
