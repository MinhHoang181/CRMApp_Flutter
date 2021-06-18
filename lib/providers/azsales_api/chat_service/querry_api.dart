import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/Facebook/FacebookPage.dart';
import 'package:graphql/client.dart';

GraphQLClient _getChatClient() {
  final Link link = HttpLink(
    'https://chat-service-dev.azsales.vn/graphql',
    defaultHeaders: {
      'access_token': AzsalesData.instance.azsalesAccessToken,
    },
  );
  return GraphQLClient(
    link: link,
    cache: GraphQLCache(),
  );
}

Future<bool> fetchAzsalesData() async {
  final String pagesQuery = """
    page {
      pages {
        _id,
        name,
      }
    } 
  """;
  final String quickReplyQuery = """
    quickReply {
      quickReplies {
        _id,
        text,
        shortcut,
      }
    }
  """;
  final QueryOptions options = QueryOptions(
    document: gql(
      '''
        query {
          $pagesQuery,
          $quickReplyQuery,
        }
      ''',
    ),
  );
  final GraphQLClient client = _getChatClient();

  final response = await client.query(options);
  if (response.hasException) {
    print(response.exception.toString());
    throw Exception('Lỗi lấy dữ liệu cơ bản trên Azsales');
  }
  //pages
  List<dynamic> pages = response.data['page']['pages'];
  pages.forEach((element) {
    AzsalesData.instance.addPage(FacebookPage.fromJson(element));
  });
  //labels
  AzsalesData.instance.labels.fetchData();
  //QuickReply
  AzsalesData.instance.replies.fetchData();
  return true;
}
