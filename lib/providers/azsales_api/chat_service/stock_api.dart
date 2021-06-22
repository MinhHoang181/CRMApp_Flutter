import 'package:cntt2_crm/models/Stock.dart';
import 'package:cntt2_crm/providers/azsales_api/url_api.dart';
import 'package:graphql/client.dart';

class StockAPI {
  static Future<List<Stock>> fetchAllStock() async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          stock {
            stocks {
              _id,
              name,
            }
          }
        }
        ''',
      ),
    );
    final GraphQLClient client = getPosClient();
    final response = await client.query(options);
    if (response.hasException) {
      print(response.exception.toString());
      return null;
    } else {
      List<dynamic> stocksJson = response.data['stock']['stocks'];
      List<Stock> stocks = List.empty(growable: true);
      stocksJson.forEach((stock) {
        stocks.add(Stock.fromJson(stock));
      });
      return stocks;
    }
  }
}
