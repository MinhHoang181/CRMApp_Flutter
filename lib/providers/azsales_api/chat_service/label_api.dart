import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/Label.dart';
import 'package:cntt2_crm/providers/azsales_api/url_api.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

class LabelAPI {
  static Future<bool> fetchAllLabels() async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          label {
            labels {
              _id,
              title,
              textColor,
              color,
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
      return false;
    }
    List<dynamic> labels = response.data['label']['labels'];
    labels.forEach((element) {
      AzsalesData.instance.addLabel(Label.fromJson(element));
    });
    return true;
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
    final response = await client.mutate(options);
    if (response.hasException) {
      print(response.exception.toString());
      return null;
    }
    final json = response.data['label']['createLabel']['record'];
    return Label.fromJson(json);
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
    final response = await client.mutate(options);
    if (response.hasException) {
      print(response.exception.toString());
      return null;
    }
    final json = response.data['label']['updateLabel']['record'];
    return Label.fromJson(json);
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
    final response = await client.mutate(options);
    if (response.hasException) {
      print(response.exception.toString());
      return false;
    }
    final id = response.data['label']['removeLabelById']['record']['_id'];
    return labelId == id;
  }
}
