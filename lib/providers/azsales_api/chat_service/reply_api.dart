import 'package:cntt2_crm/models/QuickReply.dart';
import 'package:cntt2_crm/providers/azsales_api/url_api.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

class ReplyAPI {
  static Future<List<QuickReply>> fetchAllReplies() async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          quickReply {
            quickReplies {
              _id,
              shortcut,
              text,
            }
          }
        }
      ''',
      ),
    );
    final GraphQLClient client = getChatClient();
    final response = await client.query(options);
    if (response.hasException) {
      print(response.exception);
      return null;
    } else {
      List<dynamic> repliesJson = response.data['quickReply']['quickReplies'];
      List<QuickReply> replies = List.empty(growable: true);
      repliesJson.forEach((reply) {
        replies.add(QuickReply.fromJson(reply));
      });
      return replies;
    }
  }

  static Future<QuickReply> createReply({
    @required String shortcut,
    @required String text,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(
        '''
        mutation {
          quickReply {
            createQuickReply(record: {shortcut: "$shortcut", text: "$text"}) {
              record {
                _id,
                shortcut,
                text,
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
      print(response.exception);
      return null;
    } else {
      final json = response.data['quickReply']['createQuickReply']['record'];
      return QuickReply.fromJson(json);
    }
  }

  static Future<QuickReply> updateReply({
    @required String id,
    @required shortcut,
    @required text,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(
        '''
        mutation {
          quickReply {
            updateQuickReply(record: {shortcut: "$shortcut", text: "$text"}, filter: {_id: "$id"}) {
              record {
                _id,
                shortcut,
                text,
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
      print(response.exception);
      return null;
    } else {
      final json = response.data['quickReply']['updateQuickReply']['record'];
      return QuickReply.fromJson(json);
    }
  }
}
