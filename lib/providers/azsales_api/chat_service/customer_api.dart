import 'package:cntt2_crm/models/Customer.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/location_api.dart';
import 'package:cntt2_crm/providers/azsales_api/url_api.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

class CustomerAPI {
  static Future<List<Customer>> fetchAllCustomersOfConversation({
    @required String conversationId,
  }) async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          order {
            orders(filter: { conversation_id: "$conversationId" }) {
              customer {
                _id
                customer_name
                phone_number
                address
                city_code
                district_code
                ward_code
              }
            }
          }
        }
        ''',
      ),
    );
    final GraphQLClient client = getPosClient();
    final response = await client.query(options).timeout(
          timeout,
          onTimeout: () => null,
        );
    if (response == null) return null;
    if (response.hasException) {
      print(response.exception);
      return null;
    } else {
      List<dynamic> customersJson = response.data['order']['orders'];
      List<Customer> customers = List.empty(growable: true);
      await Future.forEach(customersJson, (customer) async {
        await LocationAPI.fetchAddress(
          address: customer['customer']['address'],
          cityCode: customer['customer']['city_code'],
          districtCode: customer['customer']['district_code'],
          wardCode: customer['customer']['ward_code'],
        ).then((address) {
          customers.add(Customer.fromJson(customer, address));
        });
      });
      return customers;
    }
  }
}
