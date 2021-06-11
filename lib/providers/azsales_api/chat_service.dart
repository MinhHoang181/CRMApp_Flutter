import 'dart:convert';
import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/ChatMessage.dart';
import 'package:cntt2_crm/models/Conversation.dart';
import 'package:cntt2_crm/models/Facebook/FacebookPage.dart';
import 'package:cntt2_crm/models/Label.dart';
import 'package:cntt2_crm/models/Paging/ConversationPage.dart';
import 'package:cntt2_crm/models/Paging/MessagePage.dart';
import 'package:cntt2_crm/models/Paging/PagingInfo.dart';
import 'package:cntt2_crm/models/QuickReply.dart';
import 'package:http/http.dart' as http;

const azsales_chat_api_url = 'chat-service-dev.azsales.vn';
const String unencodedPath = 'graphql';

Future<bool> fetchAzsalesData() async {
  final String pages = """
    page {
      pages {
        _id,
        name,
      }
    } 
  """;
  final String labels = """
    label {
      labels {
        _id,
        title,
        textColor,
        color,
      }
    }
  """;
  final String quickReply = """
    quickReply {
      quickReplies {
        _id,
        text,
        shortcut,
      }
    }
  """;
  final String query = """
    {
      $pages
      $labels
      $quickReply
    }
  """;

  final response = await http.get(
    Uri.https(
      azsales_chat_api_url,
      unencodedPath,
      {
        'query': query,
      },
    ),
    headers: {
      'access_token': AzsalesData.instance.azsalesAccessToken,
    },
  );

  if (response.statusCode == 200) {
    //pages
    List<dynamic> pages = jsonDecode(response.body)['data']['page']['pages'];
    pages.forEach((element) {
      AzsalesData.instance.addPage(FacebookPage.fromJson(element));
    });
    //labels
    List<dynamic> labels = jsonDecode(response.body)['data']['label']['labels'];
    labels.forEach((element) {
      AzsalesData.instance.addLabel(Label.fromJson(element));
    });
    //QuickReply
    List<dynamic> replies =
        jsonDecode(response.body)['data']['quickReply']['quickReplies'];
    replies.forEach((element) {
      AzsalesData.instance.addReply(QuickReply.fromJson(element));
    });
    return true;
  } else {
    print(response.body);
    throw Exception('Lỗi lấy dữ liệu cơ bản trên Azsales');
  }
}

Future<ConversationPage> fetchConversationsAllPages({
  int start,
  int min,
}) async {
  final String query = """
    {
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
  """;
  final response = await http.get(
    Uri.https(
      azsales_chat_api_url,
      unencodedPath,
      {
        'query': query,
      },
    ),
    headers: {
      'access_token': AzsalesData.instance.azsalesAccessToken,
    },
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> conversations =
        json['data']['conversation']['conversationsPaging']['items'];
    conversations.forEach((conversation) {
      AzsalesData.instance.conversations
          .add(Conversation.fromJson(conversation));
    });
    Map<String, dynamic> pageInfo =
        json['data']['conversation']['conversationsPaging']['pageInfo'];
    AzsalesData.instance.conversations.pageInfo = PagingInfo.fromJson(pageInfo);
    return AzsalesData.instance.conversations;
  } else {
    print(response.body);
    throw Exception('Lỗi load thông tin danh sách tin nhắn của mọi Page');
  }
}

Future<MessagePage> fetchMessages({
  String conversationId,
  int start,
  int min,
}) async {
  final query = """
  {
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
  """;
  final response = await http.get(
    Uri.https(
      azsales_chat_api_url,
      unencodedPath,
      {
        'query': query,
      },
    ),
    headers: {
      'access_token': AzsalesData.instance.azsalesAccessToken,
    },
  );

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body)['data']['message']['messagesPaging'];
    Conversation conversation =
        AzsalesData.instance.conversations.list[conversationId];
    conversation.messages.pageInfo = PagingInfo.fromJson(json['pageInfo']);
    List<dynamic> items = json['items'];
    items.forEach((message) {
      conversation.messages
          .add(ChatMessage.fromJson(message, conversation.pageId));
    });
    return conversation.messages;
  } else {
    throw Exception('Lỗi lấy dữ liệu tin nhắn');
  }
}
