import 'package:cntt2_crm/models/ChatMessage.dart';
import 'package:cntt2_crm/models/Conversation/Conversation.dart';
import 'package:cntt2_crm/models/Conversation/FilterConversation.dart';
import 'package:cntt2_crm/models/PageInfo.dart';
import 'package:cntt2_crm/models/list_model/ConversationList.dart';
import 'package:cntt2_crm/providers/azsales_api/url_api.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:tuple/tuple.dart';

class ConversationAPI {
  static Future<Tuple2<List<Conversation>, PagingInfo>> fetchConversations({
    @required int start,
    @required FilterConversation filter,
  }) async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          conversation {
            conversationsPaging(start: $start, min: 20, filter: { ${filter.toGraphQL} }) {
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
    final response = await client.query(options).timeout(
          timeout,
          onTimeout: () => null,
        );
    if (response == null) return null;
    if (response.hasException) {
      print(response.exception.toString());
      return null;
    } else {
      List<Conversation> conversations = List.empty(growable: true);
      List<dynamic> conversationsJson =
          response.data['conversation']['conversationsPaging']['items'];
      await Future.forEach(conversationsJson, (json) async {
        final data = await fetchHasNotePhoneOrder(conversationId: json['_id']);
        final conversation = Conversation.fromJson(json);
        conversation.hasNote = data.item1;
        conversation.hasPhone = data.item2;
        conversation.hasOrder = data.item3;
        conversations.add(conversation);
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
    final response = await client.mutate(options).timeout(
          timeout,
          onTimeout: () => null,
        );
    if (response == null) return null;
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
    final response = await client.mutate(options).timeout(
          timeout,
          onTimeout: () => null,
        );
    if (response == null) return null;
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

  static Future<bool> setIsRead({
    @required String conversationId,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(
        '''
        mutation {
          conversation {
            setIsRead(conversationId: "$conversationId", isRead: true) {
              _id,
              is_read,
            }
          }
        }
        ''',
      ),
    );

    final client = getChatClient();
    final response = await client.mutate(options).timeout(
          timeout,
          onTimeout: () => null,
        );
    if (response == null) return false;
    if (response.hasException) {
      print(response.exception.toString());
      return false;
    } else {
      final bool check = response.data['conversation']['setIsRead']['is_read'];
      return check;
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
    final response = await client.mutate(options).timeout(
          timeout,
          onTimeout: () => null,
        );
    if (response == null) return null;
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

  static Future<Tuple3<bool, bool, bool>> fetchHasNotePhoneOrder({
    @required String conversationId,
  }) async {
    final QueryOptions noteOptions = QueryOptions(
      document: gql(
        '''
        query {
          note {
            notesPaging(filter: {reference_id: "$conversationId" }) {
              pageInfo {
                itemCount
              }
            }
          }
        }
        ''',
      ),
    );
    final QueryOptions orderOptions = QueryOptions(
      document: gql(
        '''
        query {
          order {
            ordersPaging(filter: {conversation_id: "$conversationId"}) {
              pageInfo {
                itemCount
              }
            }
          }
        }
        ''',
      ),
    );
    final GraphQLClient noteClient = getChatClient();
    final GraphQLClient orderClient = getPosClient();

    bool hasNote = false;
    bool hasOrder = false;
    bool hasPhone = false;

    final noteResponse = await noteClient.query(noteOptions).timeout(
          timeout,
          onTimeout: () => null,
        );
    final orderReponse = await orderClient.query(orderOptions).timeout(
          timeout,
          onTimeout: () => null,
        );
    if (noteResponse != null) {
      if (noteResponse.hasException) {
        print(noteResponse.exception.toString());
      } else {
        int number =
            noteResponse.data['note']['notesPaging']['pageInfo']['itemCount'];
        hasNote = number > 0;
      }
    }
    if (orderReponse != null) {
      if (orderReponse.hasException) {
        print(orderReponse.exception.toString());
      } else {
        int number =
            orderReponse.data['order']['ordersPaging']['pageInfo']['itemCount'];
        hasOrder = number > 0;
        hasPhone = number > 0;
      }
    }
    return Tuple3(hasNote, hasPhone, hasOrder);
  }
}
