import 'package:cntt2_crm/models/Customer.dart';
import 'package:cntt2_crm/models/Location/Address.dart';
import 'package:cntt2_crm/models/Order/CartProduct.dart';
import 'package:cntt2_crm/models/Stock.dart';
import 'package:cntt2_crm/utilities/datetime.dart';
import 'package:flutter/material.dart';
import 'StatusOrder.dart';
import 'TypeOrder.dart';

class Order extends ChangeNotifier {
  final String id;
  final int numberId;
  final String conversationId;
  final String createBy;
  Customer customer;
  String recipientName;
  String recipientPhone;
  int bankPaymen;
  int cashPaymen;
  int cardPaymen;
  int otherPaymen;
  int discount;
  int amount;
  int cod;
  Address address;
  String phone;
  StatusOrder status;
  TypeOrder type;
  final String dateCreated;
  final int timeCreated;
  String externalNote;
  String internalNote;
  Stock stock;
  List<CartProduct> products;

  Order({
    @required this.id,
    @required this.numberId,
    @required this.conversationId,
    @required this.createBy,
    @required this.customer,
    @required this.recipientName,
    @required this.recipientPhone,
    @required this.bankPaymen,
    @required this.cashPaymen,
    @required this.cardPaymen,
    @required this.otherPaymen,
    @required this.discount,
    @required this.amount,
    @required this.cod,
    @required this.address,
    @required this.phone,
    @required this.status,
    @required this.type,
    @required this.dateCreated,
    @required this.timeCreated,
    @required this.externalNote,
    @required this.internalNote,
    @required this.stock,
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
      customer: Customer.fromJsonOrder(json['customer']),
      recipientName: json['recipient_name'],
      recipientPhone: json['recipient_phone_number'],
      bankPaymen: json['bank_payment'],
      cashPaymen: json['cash_payment'],
      cardPaymen: json['card_payment'],
      otherPaymen: json['other_payment'],
      discount: json['discount'],
      amount: json['amount'],
      cod: json['COD'],
      address: Address.fromJson(json),
      phone: json['phone_number'],
      status: StatusOrder.fromCode(code: json['status']),
      type: TypeOrder(code: json['minetype']),
      dateCreated: readTimestampHHDMYYYY(json['date_created']),
      timeCreated: json['date_created'],
      externalNote: json['external_note'],
      internalNote: json['internal_note'],
      stock: Stock.fromJson(json['stock']),
      products: products,
    );
  }

  void update(Order order) {
    this.customer = order.customer;
    this.recipientName = order.recipientName;
    this.recipientPhone = order.recipientPhone;
    this.bankPaymen = order.bankPaymen;
    this.cashPaymen = order.cashPaymen;
    this.cardPaymen = order.cardPaymen;
    this.otherPaymen = order.otherPaymen;
    this.discount = order.discount;
    this.amount = order.amount;
    this.cod = order.cod;
    this.address = order.address;
    this.phone = order.phone;
    this.status = order.status;
    this.type = order.type;
    this.externalNote = order.externalNote;
    this.internalNote = order.internalNote;
    this.stock = order.stock;
    this.products = order.products;
    notifyListeners();
  }

  void updateStatus(StatusOrder statusOrder) {
    this.status = statusOrder;
    notifyListeners();
  }
}
