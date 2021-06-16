import 'package:cntt2_crm/models/Order.dart';
import 'package:cntt2_crm/models/list_model/OrderList.dart';
import 'package:cntt2_crm/providers/azsales_api/url_api.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:tuple/tuple.dart';

class OrderAPI {
  static Future<Tuple2<List<Order>, OrderPagingInfor>> fetchOrders({
    int page = 1,
  }) async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          order {
            ordersPaging(page: $page, sort: ID_DESC) {
              pageInfo {
                hasNextPage,
                currentPage,
              }
              items {
                _id,
                id,
                conversation_id,
                phone_number,
                COD,
                address,
                city {
                  _id
                  label,
                }
                district {
                  _id
                  label,
                }
                ward {
                  _id
                  label,
                }
                status,
                date_created,
                created_by_user {
                  display_name,
                }
              }
            }
          }
        }
        ''',
      ),
    );
    final GraphQLClient client = getPosClient();
    final response = await client.query(options);
    if (response.hasException) {
      print(response.exception);
    }
    List<dynamic> ordersJson = response.data['order']['ordersPaging']['items'];
    List<Order> orders = List.empty(growable: true);
    ordersJson.forEach((order) {
      orders.add(Order.fromJson(order));
    });
    Map<String, dynamic> pageInfo =
        response.data['order']['ordersPaging']['pageInfo'];
    return Tuple2(orders, OrderPagingInfor.fromJson(pageInfo));
  }

  static Future<Tuple2<List<Order>, OrderPagingInfor>>
      fetchOrdersOfConversation({
    @required String conversationId,
    int page = 1,
  }) async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          order {
            ordersPaging(page: $page, filter: {conversation_id: "$conversationId"}, sort: ID_DESC) {
              pageInfo {
                hasNextPage,
                currentPage,
              }
              items {
                _id,
                id,
                conversation_id,
                phone_number,
                COD,
                address,
                city {
                  _id
                  label,
                }
                district {
                  _id
                  label,
                }
                ward {
                  _id
                  label,
                }
                status,
                date_created,
                created_by_user {
                  display_name,
                }
              }
            }
          }
        }
        ''',
      ),
    );
    final GraphQLClient client = getPosClient();
    final response = await client.query(options);
    if (response.hasException) {
      print(response.exception);
    }
    List<dynamic> ordersJson = response.data['order']['ordersPaging']['items'];
    List<Order> orders = List.empty(growable: true);
    ordersJson.forEach((order) {
      orders.add(Order.fromJson(order));
    });
    Map<String, dynamic> pageInfo =
        response.data['order']['ordersPaging']['pageInfo'];
    return Tuple2(orders, OrderPagingInfor.fromJson(pageInfo));
  }
}
