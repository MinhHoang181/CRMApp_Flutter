import 'package:cntt2_crm/models/ChatMessage.dart';
import 'package:cntt2_crm/models/Conversation.dart';
import 'package:cntt2_crm/models/PagingInfo.dart';
import 'package:cntt2_crm/models/list_model/ConversationList.dart';
import 'package:cntt2_crm/providers/azsales_api/url_api.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:tuple/tuple.dart';

class ConversationAPI {
  static Future<Tuple2<List<Conversation>, PagingInfo>>
      fetchConversationsAllPages({
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
      return null;
    } else {
      List<Conversation> conversations = List.empty(growable: true);
      List<dynamic> conversationsJson =
          response.data['conversation']['conversationsPaging']['items'];
      conversationsJson.forEach((conversation) {
        conversations.add(Conversation.fromJson(conversation));
      });
      Map<String, dynamic> pageInfo =
          response.data['conversation']['conversationsPaging']['pageInfo'];
      return Tuple2(conversations, PagingInfo.fromJson(pageInfo));
    }
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
      return null;
    } else {
      Map<String, dynamic> setLabel = response.data['conversation']['setLabel'];
      List<String> labelIds = List.empty(growable: true);
      List<dynamic> labels = setLabel['label_ids'];
      labels.forEach((label) {
        labelIds.add(label);
      });
      return conversationId == setLabel['_id'] ? labelIds : null;
    }
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
      return null;
    } else {
      Map<String, dynamic> setLabel =
          response.data['conversation']['unsetLabel'];
      List<String> labelIds = List.empty(growable: true);
      List<dynamic> labels = setLabel['label_ids'];
      labels.forEach((label) {
        labelIds.add(label);
      });
      return conversationId == setLabel['_id'] ? labelIds : null;
    }
  }

  static Future<bool> notifyConversationChanged({
    @required String conversationId,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(
        '''
        mutation {
          conversation {
            notifyConversationChanged(conversationId: "$conversationId") {
              success
              error {
                message
              }
            }
          }
        }
        ''',
      ),
    );

    final GraphQLClient client = getChatClient();
    final response = await client.mutate(options);
    if (response.hasException) {
      print(response.exception.toString());
      return false;
    } else {
      Map<String, dynamic> json =
          response.data['conversation']['notifyConversationChanged'];
      bool success = json['success'];
      return success;
    }
  }

  //Subscriptions
  static void listenChangeConversation({
    @required ConversationList conversations,
  }) {
    final SubscriptionOptions options = SubscriptionOptions(
      document: gql(
        '''
        subscription {
          conversationChanged {
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
        ''',
      ),
    );

    final GraphQLClient client = getChatClient();
    final subscription = client.subscribe(options);
    subscription.listen((event) {
      if (event.hasException) {
        print(event.exception.toString());
        return;
      }
      if (event.isLoading) {
        return;
      }
      Map<String, dynamic> conversation = event.data['conversationChanged'];
      if (conversation != null) {
        conversations.listenUpdate(Conversation.fromJson(conversation));
      }
    });
  }

  static void listenIsReadChanged({
    @required ConversationList conversations,
  }) {
    final SubscriptionOptions options = SubscriptionOptions(
      document: gql(
        '''
        subscription {
          conversationIsReadChanged {
            _id,
            is_read,
          }
        }
        ''',
      ),
    );
    final GraphQLClient client = getChatClient();
    final subscription = client.subscribe(options);
    subscription.listen((event) {
      if (event.hasException) {
        print(event.exception.toString());
        return;
      }
      if (event.isLoading) {
        return;
      }
      Map<String, dynamic> conversation =
          event.data['conversationIsReadChanged'];
      if (conversation != null) {
        conversations.listenUpdateRead(
            conversation['_id'], conversation['is_read']);
      }
    });
  }

  static void listenMessageChanged({
    @required ConversationList conversationList,
  }) {
    final SubscriptionOptions options = SubscriptionOptions(
      document: gql(
        '''
        subscription {
          messageChanged {
            _id
            conversation_id,
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
        ''',
      ),
    );
    final GraphQLClient client = getChatClient();
    final subscription = client.subscribe(options);
    subscription.listen((event) {
      if (event.hasException) {
        print(event.exception.toString());
        return;
      }
      if (event.isLoading) {
        return;
      }
      Map<String, dynamic> message = event.data['messageChanged'];
      String conversationId = message['conversation_id'];
      if (message != null) {
        conversationList.listenReceiveMessage(
          conversationId,
          ChatMessage.fromJson(
              message, conversationList.getPageId(conversationId)),
        );
      }
    });
  }
}
