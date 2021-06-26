import 'package:cntt2_crm/models/Cart.dart';
import 'package:cntt2_crm/models/Order/FilterOrder.dart';
import 'package:cntt2_crm/models/Order/Order.dart';
import 'package:cntt2_crm/models/PageInfo.dart';
import 'package:cntt2_crm/providers/azsales_api/url_api.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:tuple/tuple.dart';

class OrderAPI {
  static Future<Tuple2<List<Order>, PageInfo>> fetchOrders({
    int page = 1,
    FilterOrder filterOrder = FilterOrder.all,
  }) async {
    String filter;
    switch (filterOrder) {
      case FilterOrder.status_new:
        filter = 'filter: {status: 1}';
        break;
      case FilterOrder.status_confirmed:
        filter = 'filter: {status: 2}';
        break;
      case FilterOrder.status_sent:
        filter = 'filter: {status: 3}';
        break;
      case FilterOrder.status_done:
        filter = 'filter: {status: 4}';
        break;
      case FilterOrder.status_return_all:
        filter = 'filter: {OR: [{status: 5} {status: 6}] }';
        break;
      case FilterOrder.status_returning:
        filter = 'filter: {status: 5}';
        break;
      case FilterOrder.status_returned:
        filter = 'filter: {status: 6}';
        break;
      default:
        filter = '';
    }
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          order {
            ordersPaging(page: $page, sort: ID_DESC, $filter) {
              pageInfo {
                hasNextPage,
                currentPage,
              }
              items {
                _id,
                id,
                conversation_id,
                customer {
                  _id
                  customer_name
                  phone_number
                }
                recipient_name
                recipient_phone_number
                phone_number,
                amount,
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
                minetype,
                cart_items {
                  _id
                  product_name
                  product_id_ref
                  variant_id
                  qty
                  price
                  attributes {
                    name
                    value
                  }
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
      return null;
    } else {
      List<dynamic> ordersJson =
          response.data['order']['ordersPaging']['items'];
      List<Order> orders = List.empty(growable: true);
      ordersJson.forEach((order) {
        orders.add(Order.fromJson(order));
      });
      Map<String, dynamic> pageInfo =
          response.data['order']['ordersPaging']['pageInfo'];
      return Tuple2(orders, PageInfo.fromJson(pageInfo));
    }
  }

  static Future<Tuple2<List<Order>, PageInfo>> fetchOrdersOfConversation({
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
                customer {
                  _id
                  customer_name
                  phone_number
                }
                recipient_name
                recipient_phone_number
                phone_number,
                amount,
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
                minetype,
                cart_items {
                  _id
                  product_name
                  product_id_ref
                  variant_id
                  qty
                  price
                  attributes {
                    name
                    value
                  }
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
      return null;
    } else {
      List<dynamic> ordersJson =
          response.data['order']['ordersPaging']['items'];
      List<Order> orders = List.empty(growable: true);
      ordersJson.forEach((order) {
        orders.add(Order.fromJson(order));
      });
      Map<String, dynamic> pageInfo =
          response.data['order']['ordersPaging']['pageInfo'];
      return Tuple2(orders, PageInfo.fromJson(pageInfo));
    }
  }

  static Future<Order> createOrder({
    @required Cart cart,
  }) async {
    final address = cart.address != null
        ? '''
      address: "${cart.address.address}"
      city_code: ${cart.address.cityCode},
      district_code: ${cart.address.districtCode},
      ward_code: ${cart.address.wardCode},
      '''
        : '';

    final recipient = cart.whoReceive != 1
        ? '''
        recipient_name: "${cart.recipientName}",
        recipient_phone_number: "${cart.recipientPhone}",
      '''
        : '';

    final customer = cart.customer.id != null
        ? '''
        customer_id: "${cart.customer.id}"
        customer_name: "${cart.customer.name}"
        phone_number: "${cart.customer.phone}"
        '''
        : '''
        customer_name: "${cart.customer.name}"
        phone_number: "${cart.customer.phone}"
        ''';

    final externalNote = cart.externalNote != null
        ? 'external_note: "${cart.externalNote}",'
        : '';
    final internalNote = cart.internalNote != null
        ? 'internal_note: "${cart.internalNote}",'
        : '';
    final MutationOptions options = MutationOptions(
      document: gql(
        '''
        mutation {
          order {
            createOrder(record: {
              minetype: ${cart.mimeType},
              conversation_id: "${cart.conversationId}",
              $customer
              cart_items: ${cart.cartItemsJson}
              stock_id: "${cart.stock.id}"
              $address
              bank_payment: ${cart.bank},
              card_payment: ${cart.card},
              other_payment: ${cart.other},
              discount: ${cart.discount},
              $recipient
              $externalNote
              $internalNote
              initStatus: ${cart.initStatus},
            }) {
              record {
                _id
                id
                conversation_id
                phone_number
                amount
                COD
                address
                city {
                  _id
                  label
                }
                district {
                  _id
                  label
                }
                ward {
                  _id
                  label
                }
                status
                date_created
                created_by_user {
                  display_name
                }
                minetype
                cart_items {
                  _id
                  product_name
                  product_id_ref
                  variant_id
                  qty
                  price
                  attributes {
                    name
                    value
                  }
                }
              }
            }
          }
        }
        ''',
      ),
    );
    // print(
    //   '''
    //   minetype: ${cart.mimeType},
    //   conversation_id: "${cart.conversationId}",
    //   $customer
    //   cart_items: ${cart.cartItemsJson}
    //   stock_id: "${cart.stock.id}"
    //   $address
    //   bank_payment: ${cart.bank},
    //   card_payment: ${cart.card},
    //   other_payment: ${cart.other},
    //   discount: ${cart.discount},
    //   $recipient
    //   $externalNote
    //   $internalNote
    //   initStatus: ${cart.initStatus},
    //   ''',
    // );
    final GraphQLClient client = getPosClient();
    final response = await client.mutate(options);
    if (response.hasException) {
      print(response.exception.toString());
      return null;
    } else {
      Map<String, dynamic> order =
          response.data['order']['createOrder']['record'];
      return Order.fromJson(order);
    }
  }
}
