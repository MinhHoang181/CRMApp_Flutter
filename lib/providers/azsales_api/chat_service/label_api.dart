import 'package:cntt2_crm/models/Label.dart';
import 'package:cntt2_crm/providers/azsales_api/url_api.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

class LabelAPI {
  static Future<List<Label>> fetchAllLabels() async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          label {
            labels {
              _id,
              title,
              color,
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
      print(response.exception);
      return null;
    } else {
      List<dynamic> labelsJson = response.data['label']['labels'];
      List<Label> labels = List.empty(growable: true);
      labelsJson.forEach((label) {
        labels.add(Label.fromJson(label));
      });
      return labels;
    }
  }

  static Future<Label> createLabel({
    @required String labelName,
    @required String labelColor,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(
        '''
        mutation {
          label {
            createLabel(record: {title: "$labelName", color: "$labelColor", textColor: "#ffffff"}) {
              record {
                _id,
                title,
                color,
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
      return null;
    } else {
      final json = response.data['label']['createLabel']['record'];
      return Label.fromJson(json);
    }
  }

  static Future<Label> updateLabel({
    @required String labelId,
    @required String labelName,
    @required String labelColor,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(
        '''
        mutation {
          label {
            updateLabel(record: {title: "$labelName", color: "$labelColor"}, filter: {_id: "$labelId"}) {
              record {
                _id,
                title,
                color,
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
      return null;
    } else {
      final json = response.data['label']['updateLabel']['record'];
      return Label.fromJson(json);
    }
  }

  static Future<bool> removeLabel({
    @required labelId,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(
        '''
        mutation {
          label {
            removeLabelById(_id: "$labelId") {
              record {
                _id,
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
      final id = response.data['label']['removeLabelById']['record']['_id'];
      return labelId == id;
    }
  }
}
