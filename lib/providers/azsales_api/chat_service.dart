import 'dart:convert';
import 'package:cntt2_crm/models/AzsalesData.dart';
import 'package:cntt2_crm/models/Conversation.dart';
import 'package:cntt2_crm/models/Facebook/FacebookPage.dart';
import 'package:cntt2_crm/models/Label.dart';
import 'package:cntt2_crm/models/QuickReply.dart';
import 'package:http/http.dart' as http;

const azsales_chat_api_url = 'chat-service-dev.azsales.vn';
const String unencodedPath = 'graphql';

Future<bool> fetchAzsalesData(String accessToken) async {
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
      'access_token': accessToken,
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

Future<List<FacebookPage>> fetchPages(String accessToken) async {
  final String query = """
    {
      page {
        pages {
          _id,
          name,
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
      'access_token': accessToken,
    },
  );

  if (response.statusCode == 200) {
    List<FacebookPage> list = List.empty(growable: true);
    List<dynamic> pages = jsonDecode(response.body)['data']['page']['pages'];
    pages.forEach((element) {
      list.add(FacebookPage.fromJson(element));
    });
    return list;
  } else {
    print(response.body);
    throw Exception('Lỗi lấy tất cả trang');
  }
}

Future<List<Conversation>> fetchConversationsAllPages(
    String accessToken) async {
  final String query = """
    {
      conversation {
        buckets {
          conversations {
            _id
            page_id
            participants {
              _id,
              name,
            }
            snippet,
            is_read,
            is_replied,
            label_ids,
            page_id,
            updated_time,
            has_note,
            has_order,
            has_phone,
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
      'access_token': accessToken,
    },
  );

  if (response.statusCode == 200) {
    List<Conversation> list = List.empty(growable: true);
    List<dynamic> buckets =
        jsonDecode(response.body)['data']['conversation']['buckets'];
    buckets.forEach((bucket) {
      List<dynamic> conversations = bucket['conversations'];
      if (conversations.isNotEmpty) {
        conversations.forEach((element) {
          list.add(Conversation.fromJson(element));
        });
      }
    });
    return list;
  } else {
    print(response.body);
    throw Exception('Lỗi load thông tin danh sách tin nhắn của mọi Page');
  }
}
