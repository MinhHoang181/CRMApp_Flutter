import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/ChatMessage.dart';
import 'package:cntt2_crm/models/Conversation.dart';
import 'package:cntt2_crm/models/Facebook/FacebookPage.dart';
import 'package:cntt2_crm/models/list_model/MessageList.dart';
import 'package:cntt2_crm/models/PagingInfo.dart';
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

Future<MessageList> fetchMessages({
  String conversationId,
  int start,
  int min,
}) async {
  final QueryOptions options = QueryOptions(
    document: gql(
      '''
        query {
          message {
            messagesPaging(
              start: $start
              min: $min
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
  final GraphQLClient client = _getChatClient();
  final response = await client.query(options);
  if (response.hasException) {
    print(response.exception.toString());
    throw Exception('Lỗi lấy dữ liệu tin nhắn');
  }
  final json = response.data['message']['messagesPaging'];
  Conversation conversation =
      AzsalesData.instance.conversations.map[conversationId];
  conversation.messages.pageInfo = PagingInfo.fromJson(json['pageInfo']);
  List<dynamic> items = json['items'];
  items.forEach((message) {
    conversation.messages
        .add(ChatMessage.fromJson(message, conversation.pageId));
  });

  return conversation.messages;
}
