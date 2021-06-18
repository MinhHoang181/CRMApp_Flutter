import 'package:cntt2_crm/models/Customer.dart';
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
              }
              address,
              city {
                _id,
                label,
              }
              district {
                _id,
                label,
              }
              ward {
                _id,
                label,
              }
            }
          }
        }
        ''',
      ),
    );
    final GraphQLClient client = getPosClient();
    final response = await client.query(options);

    List<Customer> customers = List.empty(growable: true);

    if (response.hasException) {
      print(response.exception);
    } else {
      List<dynamic> customersJson = response.data['order']['orders'];
      customersJson.forEach((customer) {
        customers.add(Customer.fromJson(customer));
      });
    }
    return customers;
  }
}
