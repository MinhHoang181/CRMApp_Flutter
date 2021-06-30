import 'package:cntt2_crm/models/ChatMessage.dart';
import 'package:cntt2_crm/models/PageInfo.dart';
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
    final response = await client.query(options).timeout(
          timeout,
          onTimeout: () => null,
        );
    if (response == null) return null;
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

  static Future<String> sendMessage({
    @required String pageId,
    @required String recipientId,
    @required ChatMessage message,
  }) async {
    MutationOptions options;
    switch (message.messageType) {
      case MessageType.text:
        options = MutationOptions(
          document: gql(
            '''
              mutation {
                message {
                  sendMessage(
                    record: {
                      page_id: "$pageId"
                      recipient_id: "$recipientId"
                      message: {
                        text: "${message.message}"
                      }
                    }
                  ) {
                    _id
                  }
                }
              }
              ''',
          ),
        );
        break;
      case MessageType.attachment:
        options = MutationOptions(
          document: gql(
            '''
              mutation {
                message {
                  sendMessage(
                    record: {
                      page_id: "$pageId"
                      recipient_id: "$recipientId"
                      message: {
                        attachment: { type: "image", url: "${message.attachments[0].url}" }
                      }
                    }
                  ) {
                    _id
                  }
                }
              }
              ''',
          ),
        );
        break;
      default:
    }

    final GraphQLClient client = getChatClient();
    final response = await client.mutate(options).timeout(
          timeout,
          onTimeout: () => null,
        );
    if (response == null) return null;
    if (response.hasException) {
      print(response.exception.toString());
      return null;
    } else {
      return response.data['message']['sendMessage']['_id'];
    }
  }

  static Future<bool> notifyMessageChanged({
    @required String messageId,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(
        '''
        mutation {
          message {
            notifyMessageChanged(messageId: "$messageId") {
              success,
              error {
                message,
              }
            }
          }
        }
        ''',
      ),
    );
    final GraphQLClient client = getChatClient();
    final response = await client.mutate(options).timeout(
          timeout,
          onTimeout: () => null,
        );
    if (response == null) return false;
    if (response.hasException) {
      print(response.exception.toString());
      return false;
    } else {
      return response.data['message']['notifyMessageChanged']['success'];
    }
  }
}
