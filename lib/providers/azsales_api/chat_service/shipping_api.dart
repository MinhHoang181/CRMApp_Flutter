import 'package:cntt2_crm/models/Shipper.dart';
import 'package:cntt2_crm/providers/azsales_api/url_api.dart';
import 'package:graphql/client.dart';

class ShippingAPI {
  static Future<List<Shipper>> fetchAllShipper() async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          shipping {
            partners {
              _id
              name
              description
              logo
              transports{
                _id
                name
                is_active
              }
              is_active
            }
          }
        }
        ''',
      ),
    );

    final GraphQLClient client = getShippingClient();
    final response = await client.query(options).timeout(
          timeout,
          onTimeout: () => null,
        );
    if (response == null) return null;
    if (response.hasException) {
      print(response.exception.toString());
      return null;
    } else {
      List<dynamic> shippersJson = response.data['shipping']['partners'];
      List<Shipper> shippers = List.empty(growable: true);
      shippersJson.forEach((shipper) {
        shippers.add(Shipper.fromJson(shipper));
      });
      return shippers;
    }
  }
}
