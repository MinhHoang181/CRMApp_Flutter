import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/Conversation.dart';
import 'package:cntt2_crm/models/Paging/ConversationPage.dart';
import 'package:cntt2_crm/models/Paging/PagingInfo.dart';
import 'package:cntt2_crm/providers/azsales_api/url_api.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

class ConversationAPI {
  static Future<ConversationPage> fetchConversationsAllPages({
    int start,
    int min,
  }) async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          conversation {
            conversationsPaging(start: $start, min: $min) {
              pageInfo {
                hasNextPage
                next
                start
                min
              }
              items {
                _id
                page_id
                participants {
                  _id
                  name
                }
                snippet
                is_read
                is_replied
                label_ids
                page_id
                updated_time
                has_note
                has_order
                has_phone
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
      throw Exception('Lỗi load thông tin danh sách tin nhắn của mọi Page');
    }
    List<dynamic> conversations =
        response.data['conversation']['conversationsPaging']['items'];
    conversations.forEach((conversation) {
      AzsalesData.instance.conversations
          .add(Conversation.fromJson(conversation));
    });
    Map<String, dynamic> pageInfo =
        response.data['conversation']['conversationsPaging']['pageInfo'];
    AzsalesData.instance.conversations.pageInfo = PagingInfo.fromJson(pageInfo);

    return AzsalesData.instance.conversations;
  }

  static Future<List<String>> setLabel({
    @required String conversationId,
    @required String labelId,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(
        '''
          mutation {
            conversation {
              setLabel(conversationId: "$conversationId", labelId: "$labelId") {
                _id,
                label_ids,
              }
            }
          }
        ''',
      ),
    );
    final GraphQLClient client = getChatClient();
    final response = await client.mutate(options);
    if (response.hasException) {
      print(response.exception);
      throw Exception('Lỗi set label cho hội thoại');
    }
    Map<String, dynamic> setLabel = response.data['conversation']['setLabel'];
    if (setLabel != null) {
      List<String> labelIds = List.empty(growable: true);
      List<dynamic> labels = setLabel['label_ids'];
      labels.forEach((label) {
        labelIds.add(label);
      });
      return conversationId == setLabel['_id'] ? labelIds : null;
    }
    return null;
  }

  static Future<List<String>> unsetLabel({
    @required String conversationId,
    @required String labelId,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(
        '''
          mutation {
            conversation {
              unsetLabel(conversationId: "$conversationId", labelId: "$labelId") {
                _id,
                label_ids,
              }
            }
          }
        ''',
      ),
    );
    final GraphQLClient client = getChatClient();
    final response = await client.mutate(options);
    if (response.hasException) {
      print(response.exception);
      throw Exception('Lỗi unset label cho hội thoại');
    }
    Map<String, dynamic> setLabel = response.data['conversation']['unsetLabel'];
    if (setLabel != null) {
      List<String> labelIds = List.empty(growable: true);
      List<dynamic> labels = setLabel['label_ids'];
      labels.forEach((label) {
        labelIds.add(label);
      });
      return conversationId == setLabel['_id'] ? labelIds : null;
    }
    return null;
  }
}
