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
                bank_payment,
                cash_payment,
                card_payment,
                other_payment,
                discount,
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
                internal_note
                external_note
                stock {
                  _id
                  name
                }
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
    final response = await client.query(options).timeout(
          timeout,
          onTimeout: () => null,
        );
    if (response == null) return null;
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
                bank_payment,
                cash_payment,
                card_payment,
                other_payment,
                discount,
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
                internal_note
                external_note
                stock {
                  _id
                  name
                }
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
    final response = await client.query(options).timeout(
          timeout,
          onTimeout: () => null,
        );
    if (response == null) return null;
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

    if (cart.initStatus == 0) cart.initStatus = 1;

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
                bank_payment,
                cash_payment,
                card_payment,
                other_payment,
                discount,
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
                internal_note
                external_note
                stock {
                  _id
                  name
                }
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
    final response = await client.mutate(options).timeout(
          timeout,
          onTimeout: () => null,
        );
    if (response == null) return null;
    if (response.hasException) {
      print(response.exception.toString());
      return null;
    } else {
      Map<String, dynamic> order =
          response.data['order']['createOrder']['record'];
      return Order.fromJson(order);
    }
  }

  static Future<Order> updateOrder({
    @required String idOrder,
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

    //print('cart_items: ${cart.cartItemsJson}');

    final MutationOptions options = MutationOptions(
      document: gql(
        '''
        mutation {
          order {
            updateOrder(
              filter: { _id: "$idOrder" }
              record: {
                minetype: ${cart.mimeType},
                conversation_id: "${cart.conversationId}",
                $customer
                stock_id: "${cart.stock.id}"
                $address
                bank_payment: ${cart.bank},
                card_payment: ${cart.card},
                other_payment: ${cart.other},
                discount: ${cart.discount},
                $recipient
                $externalNote
                $internalNote
              }
            ) {
              record {
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
                bank_payment,
                cash_payment,
                card_payment,
                other_payment,
                discount,
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
                internal_note
                external_note
                stock {
                  _id
                  name
                }
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
    final response = await client.mutate(options).timeout(
          timeout,
          onTimeout: () => null,
        );
    if (response == null) return null;
    if (response.hasException) {
      print(response.exception.toString());
      return null;
    } else {
      Map<String, dynamic> order =
          response.data['order']['updateOrder']['record'];
      return Order.fromJson(order);
    }
  }

  static Future<bool> confirmOrder({
    @required String idOrder,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(
        '''
        mutation {
          order {
            confirmOrder(_id: "$idOrder"){
              status
            }
          }
        }
        ''',
      ),
    );
    final client = getPosClient();
    final response = await client.mutate(options).timeout(
          timeout,
          onTimeout: () => null,
        );
    if (response == null) return false;
    if (response.hasException) {
      print(response.exception.toString());
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> receiveOrder({
    @required String idOrder,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(
        '''
        mutation {
          order {
            receiveOrder(_id: "$idOrder"){
              status
            }
          }
        }
        ''',
      ),
    );
    final client = getPosClient();
    final response = await client.mutate(options).timeout(
          timeout,
          onTimeout: () => null,
        );
    if (response == null) return false;
    if (response.hasException) {
      print(response.exception.toString());
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> returningOrder({
    @required String idOrder,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(
        '''
        mutation {
          order {
            returningOrder(_id: "$idOrder"){
              status
            }
          }
        }
        ''',
      ),
    );
    final client = getPosClient();
    final response = await client.mutate(options).timeout(
          timeout,
          onTimeout: () => null,
        );
    if (response == null) return false;
    if (response.hasException) {
      print(response.exception.toString());
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> returnOrder({
    @required String idOrder,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(
        '''
        mutation {
          order {
            returnOrder(_id: "$idOrder"){
              status
            }
          }
        }
        ''',
      ),
    );
    final client = getPosClient();
    final response = await client.mutate(options).timeout(
          timeout,
          onTimeout: () => null,
        );
    if (response == null) return false;
    if (response.hasException) {
      print(response.exception.toString());
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> cancelOrder({
    @required String idOrder,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(
        '''
        mutation {
          order {
            updateOrder(
              filter: { _id: "$idOrder" }
              record: {}
            ) {
              record {
                status
              }
            }
            cancelOrder(_id: "$idOrder"){
              status
            }
          }
        }
        ''',
      ),
    );
    final client = getPosClient();
    final response = await client.mutate(options).timeout(
          timeout,
          onTimeout: () => null,
        );
    if (response == null) return false;
    if (response.hasException) {
      print(response.exception.toString());
      return false;
    } else {
      return true;
    }
  }

  static Future<int> fetchStatusOrderInDay({
    @required DateTime date,
    int page = 1,
    @required int status,
  }) async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          order {
            ordersPaging(page: $page, filter: {status: $status}, sort: ID_DESC) {
              pageInfo {
                hasNextPage,
                currentPage,
                itemCount,
              }
              items {
                date_created
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
      print(response.exception.toString());
      return null;
    } else {
      final int beginDay =
          DateTime(date.year, date.month, date.day).microsecondsSinceEpoch ~/
              1000;
      final int endDay = DateTime(date.year, date.month, date.day, 23, 59, 59)
              .microsecondsSinceEpoch ~/
          1000;
      int total = 0;
      final List<dynamic> ordersJson =
          response.data['order']['ordersPaging']['items'];
      final PageInfo pageInfo =
          PageInfo.fromJson(response.data['order']['ordersPaging']['pageInfo']);
      await Future(() async {
        ordersJson.forEach((order) {
          if (order['date_created'] >= beginDay &&
              order['date_created'] <= endDay) {
            total++;
          }
        });
        final last = ordersJson.length - 1;
        if (pageInfo.hasNextPage) {
          if (ordersJson[last]['date_created'] >= beginDay &&
              ordersJson[last]['date_created'] <= endDay) {
            total += await fetchStatusOrderInDay(
              date: date,
              page: page + 1,
              status: status,
            );
          }
        }
      });
      return total;
    }
  }

  static Future<int> fetchCreateOrderInDay({
    @required DateTime date,
    int page = 1,
  }) async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          order {
            ordersPaging(
              page: $page
              filter: {
                OR: [{ status: 1 }, { status: 2 }, { status: 3 }, { status: 4 }]
              }
              sort: ID_DESC
            ) {
              pageInfo {
                hasNextPage,
                currentPage,
                itemCount,
              }
              items {
                date_created
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
      print(response.exception.toString());
      return null;
    } else {
      final int beginDay =
          DateTime(date.year, date.month, date.day).microsecondsSinceEpoch ~/
              1000;
      final int endDay = DateTime(date.year, date.month, date.day, 23, 59, 59)
              .microsecondsSinceEpoch ~/
          1000;
      int total = 0;
      final List<dynamic> ordersJson =
          response.data['order']['ordersPaging']['items'];
      final PageInfo pageInfo =
          PageInfo.fromJson(response.data['order']['ordersPaging']['pageInfo']);
      await Future(() async {
        ordersJson.forEach((order) {
          if (order['date_created'] >= beginDay &&
              order['date_created'] <= endDay) {
            total++;
          }
        });
        final last = ordersJson.length - 1;
        if (pageInfo.hasNextPage) {
          if (ordersJson[last]['date_created'] >= beginDay &&
              ordersJson[last]['date_created'] <= endDay) {
            total += await fetchCreateOrderInDay(
              date: date,
              page: page + 1,
            );
          }
        }
      });
      return total;
    }
  }

  static Future<int> fetchReturnOrderInDay({
    @required DateTime date,
    int page = 1,
  }) async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          order {
            ordersPaging(
              page: $page
              filter: {
                OR: [{ status: 5 }, { status: 6 }]
              }
              sort: ID_DESC
            ) {
              pageInfo {
                hasNextPage,
                currentPage,
                itemCount,
              }
              items {
                date_updated
                date_created
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
      print(response.exception.toString());
      return null;
    } else {
      final int beginDay =
          DateTime(date.year, date.month, date.day).microsecondsSinceEpoch ~/
              1000;
      final int endDay = DateTime(date.year, date.month, date.day, 23, 59, 59)
              .microsecondsSinceEpoch ~/
          1000;
      int total = 0;
      final List<dynamic> ordersJson =
          response.data['order']['ordersPaging']['items'];
      final PageInfo pageInfo =
          PageInfo.fromJson(response.data['order']['ordersPaging']['pageInfo']);
      await Future(() async {
        ordersJson.forEach((order) {
          if (order['date_updated'] == null) {
            if (order['date_created'] >= beginDay &&
                order['date_created'] <= endDay) {
              total++;
            }
          } else {
            if (order['date_updated'] >= beginDay &&
                order['date_updated'] <= endDay) {
              total++;
            }
          }
        });
        final last = ordersJson.length - 1;
        if (pageInfo.hasNextPage) {
          if (ordersJson[last]['date_updated'] == null) {
            if (ordersJson[last]['date_created'] >= beginDay &&
                ordersJson[last]['date_created'] <= endDay) {
              total += await fetchReturnOrderInDay(
                date: date,
                page: page + 1,
              );
            }
          } else {
            if (ordersJson[last]['date_updated'] >= beginDay &&
                ordersJson[last]['date_updated'] <= endDay) {
              total += await fetchReturnOrderInDay(
                date: date,
                page: page + 1,
              );
            }
          }
        }
      });
      return total;
    }
  }

  static Future<int> fetchCancelOrderInDay({
    @required DateTime date,
    int page = 1,
  }) async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          order {
            ordersPaging(
              page: $page
              filter: {
                status: 7
              }
              sort: ID_DESC
            ) {
              pageInfo {
                hasNextPage,
                currentPage,
                itemCount,
              }
              items {
                date_updated
                date_created
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
      print(response.exception.toString());
      return null;
    } else {
      final int beginDay =
          DateTime(date.year, date.month, date.day).microsecondsSinceEpoch ~/
              1000;
      final int endDay = DateTime(date.year, date.month, date.day, 23, 59, 59)
              .microsecondsSinceEpoch ~/
          1000;
      int total = 0;
      final List<dynamic> ordersJson =
          response.data['order']['ordersPaging']['items'];
      final PageInfo pageInfo =
          PageInfo.fromJson(response.data['order']['ordersPaging']['pageInfo']);
      await Future(() async {
        ordersJson.forEach((order) {
          if (order['date_updated'] == null) {
            if (order['date_created'] >= beginDay &&
                order['date_created'] <= endDay) {
              total++;
            }
          } else {
            if (order['date_updated'] >= beginDay &&
                order['date_updated'] <= endDay) {
              total++;
            }
          }
        });
        final last = ordersJson.length - 1;
        if (pageInfo.hasNextPage) {
          if (ordersJson[last]['date_updated'] == null) {
            if (ordersJson[last]['date_created'] >= beginDay &&
                ordersJson[last]['date_created'] <= endDay) {
              total += await fetchCancelOrderInDay(
                date: date,
                page: page + 1,
              );
            }
          } else {
            if (ordersJson[last]['date_updated'] >= beginDay &&
                ordersJson[last]['date_updated'] <= endDay) {
              total += await fetchCancelOrderInDay(
                date: date,
                page: page + 1,
              );
            }
          }
        }
      });
      return total;
    }
  }

  static Future<int> fetchAmountInDay({
    @required DateTime date,
    int page = 1,
  }) async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          order {
            ordersPaging(page: $page, filter: {status: 4}, sort: ID_DESC) {
              pageInfo {
                hasNextPage,
                currentPage,
                itemCount,
              }
              items {
                date_created
                amount
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
      print(response.exception.toString());
      return null;
    } else {
      final int beginDay =
          DateTime(date.year, date.month, date.day).microsecondsSinceEpoch ~/
              1000;
      final int endDay = DateTime(date.year, date.month, date.day, 23, 59, 59)
              .microsecondsSinceEpoch ~/
          1000;
      int amount = 0;
      final List<dynamic> ordersJson =
          response.data['order']['ordersPaging']['items'];
      final PageInfo pageInfo =
          PageInfo.fromJson(response.data['order']['ordersPaging']['pageInfo']);
      await Future(() async {
        ordersJson.forEach((order) {
          if (order['date_created'] >= beginDay &&
              order['date_created'] <= endDay) {
            amount += order['amount'];
          }
        });
        final last = ordersJson.length - 1;
        if (pageInfo.hasNextPage) {
          if (ordersJson[last]['date_created'] >= beginDay &&
              ordersJson[last]['date_created'] <= endDay) {
            amount += await fetchAmountInDay(
              date: date,
              page: page + 1,
            );
          }
        }
      });
      return amount;
    }
  }

  static Future<int> fetchNumberOrder({
    @required int status,
  }) async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          order {
            ordersPaging(filter: {status: $status}) {
              pageInfo {
                itemCount
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
      print(response.exception.toString());
      return null;
    } else {
      return response.data['order']['ordersPaging']['pageInfo']['itemCount'];
    }
  }
}
