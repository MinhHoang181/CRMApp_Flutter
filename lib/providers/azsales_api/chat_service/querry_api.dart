import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/ChatMessage.dart';
import 'package:cntt2_crm/models/Conversation.dart';
import 'package:cntt2_crm/models/Facebook/FacebookPage.dart';
import 'package:cntt2_crm/models/Label.dart';
import 'package:cntt2_crm/models/Paging/MessagePage.dart';
import 'package:cntt2_crm/models/Paging/PagingInfo.dart';
import 'package:cntt2_crm/models/QuickReply.dart';
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
  final String labelsQuery = """
    label {
      labels {
        _id,
        title,
        textColor,
        color,
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
          $labelsQuery,
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
  List<dynamic> labels = response.data['label']['labels'];
  labels.forEach((element) {
    AzsalesData.instance.addLabel(Label.fromJson(element));
  });
  //QuickReply
  List<dynamic> replies = response.data['quickReply']['quickReplies'];
  replies.forEach((element) {
    AzsalesData.instance.addReply(QuickReply.fromJson(element));
  });
  return true;
}

Future<MessagePage> fetchMessages({
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
      AzsalesData.instance.conversations.list[conversationId];
  conversation.messages.pageInfo = PagingInfo.fromJson(json['pageInfo']);
  List<dynamic> items = json['items'];
  items.forEach((message) {
    conversation.messages
        .add(ChatMessage.fromJson(message, conversation.pageId));
  });

  return conversation.messages;
}

GraphQLClient _getSubscriptionClient() {
  final WebSocketLink webSocketLink = WebSocketLink(
    'wss://chat-service-dev.azsales.vn/graphql',
    config: SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: Duration(seconds: 30),
    ),
  );
  Link link = HttpLink(
    'https://chat-service-dev.azsales.vn/graphql',
    defaultHeaders: {
      'access_token': AzsalesData.instance.azsalesAccessToken,
    },
  );
  link = Link.split((request) => request.isSubscription, webSocketLink, link);
  return GraphQLClient(
    link: link,
    cache: GraphQLCache(),
  );
}

Future testSub() {
  final GraphQLClient client = _getSubscriptionClient();
  final SubscriptionOptions options = SubscriptionOptions(
    document: gql(
      '''
        subscription {
          conversationChanged {
            _id,
            label_ids,
          }
        }
      ''',
    ),
  );

  final subscription = client.subscribe(options);
  subscription.listen((event) {
    print('test: ' + event.data.toString());
  });
}
