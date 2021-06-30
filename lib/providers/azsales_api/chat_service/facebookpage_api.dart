import 'package:cntt2_crm/models/Facebook/FacebookPage.dart';
import 'package:cntt2_crm/providers/azsales_api/url_api.dart';
import 'package:graphql/client.dart';

class FacebookPageAPI {
  static Future<List<FacebookPage>> fetchAllPages() async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          page {
            pages {
              _id,
              name,
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
      List<dynamic> pagesJson = response.data['page']['pages'];
      List<FacebookPage> pages = List.empty(growable: true);
      pagesJson.forEach((page) {
        pages.add(FacebookPage.fromJson(page));
      });
      return pages;
    }
  }
}
