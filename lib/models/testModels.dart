import 'package:flutter/material.dart';

import 'Customer.dart';
import 'Label.dart';
import 'QuickAnswer.dart';

final List<Label> labelsList = [
  Label(name: 'Khách VIP', color: Colors.red),
  Label(name: 'Khách Lẻ', color: Colors.yellow),
  Label(name: 'Khách Buôn', color: Colors.green),
];
final Customer testCustomer = new Customer(name: 'test')
  ..addLabel(labelsList[0])
  ..addLabel(labelsList[2]);

final List<QuickAnswer> answerList = [
  QuickAnswer(
      'Xin chào', 'Chào mừng tới với demo Flutter app chăm sóc khách hàng'),
  QuickAnswer('Cảm ơn', 'Cảm ơn vì đã mua hàng ở cửa hàng chúng tôi'),
];
