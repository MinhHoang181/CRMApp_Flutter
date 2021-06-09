import 'dart:convert';
import 'package:cntt2_crm/models/PageFacebook.dart';
import 'package:http/http.dart' as http;

const azsales_chat_api_url = 'chat-service-dev.azsales.vn';

Future<List<PageFacebook>> fetchPages(String accessToken) async {
  final String unencodedPath = 'graphql';
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
      });

  if (response.statusCode == 200) {
    List<PageFacebook> list = List.empty(growable: true);
    List<dynamic> pages = jsonDecode(response.body)['data']['page']['pages'];
    pages.forEach((element) {
      list.add(PageFacebook.fromJson(element));
    });
    return list;
  } else {
    print(response.body);
    throw Exception('Lỗi lấy tất cả trang');
  }
}
