import 'package:cntt2_crm/models/Note.dart';
import 'package:cntt2_crm/models/list_model/NoteList.dart';
import 'package:cntt2_crm/providers/azsales_api/url_api.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:tuple/tuple.dart';

class NoteAPI {
  static Future<Tuple2<List<Note>, NotePagingInfo>> fetchNotesOfConversation({
    @required String conversationId,
    int page = 0,
  }) async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          note {
            notesPaging(page: $page, filter: {reference_id: "$conversationId"}) {
              pageInfo {
                hasNextPage,
                currentPage,
              }
              items {  
                _id,
                text,
                reference_id,
                created_by_user {
                  display_name,
                }
                date_created,
                date_updated,
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
      print(response.exception);
      return null;
    } else {
      List<dynamic> notesJson = response.data['note']['notesPaging']['items'];
      List<Note> notes = List.empty(growable: true);
      notesJson.forEach((note) {
        notes.add(Note.fromJson(note));
      });
      Map<String, dynamic> pageInfo =
          response.data['note']['notesPaging']['pageInfo'];
      return Tuple2(notes, NotePagingInfo.fromJson(pageInfo));
    }
  }

  static Future<Note> updateNote({
    @required String noteId,
    @required String text,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(
        '''
        mutation {
          note {
            updateNote(
              record: { text: "$text" }
              filter: { _id: "$noteId" }
            ) {
              record {
                _id
                text
                reference_id
                created_by_user {
                  display_name,
                }
                date_created
                date_updated
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
    } else {
      final json = response.data['note']['updateNote']['record'];
      return Note.fromJson(json);
    }
  }

  static Future<Note> createNote({
    @required String text,
    @required String conversationId,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(
        '''
        mutation {
          note {
            createNote(record: { text: "$text", reference_id: "$conversationId" }) {
              record {
                _id
                text
                reference_id
                created_by_user {
                  display_name
                }
                date_created
                date_updated
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
    } else {
      final json = response.data['note']['createNote']['record'];
      return Note.fromJson(json);
    }
  }
}
