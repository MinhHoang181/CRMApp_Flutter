import 'package:cntt2_crm/models/Address.dart';
import 'package:cntt2_crm/models/Order/CartProduct.dart';
import 'package:cntt2_crm/utilities/datetime.dart';
import 'package:flutter/material.dart';
import 'StatusOrder.dart';
import 'TypeOrder.dart';

class Order extends ChangeNotifier {
  final String id;
  final int numberId;
  final String conversationId;
  final String createBy;
  int amount;
  int cod;
  Address address;
  String phone;
  final StatusOrder status;
  final TypeOrder type;
  final String dateCreated;
  final int timeCreated;
  final List<CartProduct> products;

  Order({
    @required this.id,
    @required this.numberId,
    @required this.conversationId,
    @required this.createBy,
    @required this.amount,
    @required this.cod,
    @required this.address,
    this.phone,
    @required this.status,
    @required this.type,
    @required this.dateCreated,
    @required this.timeCreated,
    @required this.products,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    List<dynamic> cartItemsJson = json['cart_items'];
    List<CartProduct> products = List.empty(growable: true);
    cartItemsJson.forEach((product) {
      products.add(CartProduct.fromJson(product));
    });
    return Order(
      id: json['_id'],
      numberId: json['id'],
      conversationId: json['conversation_id'],
      createBy: json['created_by_user']['display_name'],
      amount: json['amount'],
      cod: json['COD'],
      address: Address.fromJson(json),
      phone: json['phone_number'],
      status: new StatusOrder(code: json['status']),
      type: new TypeOrder(code: json['minetype']),
      dateCreated: readTimestampHHDM(json['date_created']),
      timeCreated: json['date_created'],
      products: products,
    );
  }
}
