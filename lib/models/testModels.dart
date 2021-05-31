import 'package:flutter/material.dart';

import 'Customer.dart';
import 'Tag.dart';
import 'QuickAnswer.dart';

final List<Tag> tagsList = [
  Tag(name: 'Khách VIP', color: Colors.red),
  Tag(name: 'Khách Lẻ', color: Colors.yellow),
  Tag(name: 'Khách Buôn', color: Colors.green),
];
final Customer testCustomer = new Customer()
  ..addTag(tagsList[0])
  ..addTag(tagsList[2]);

final List<QuickAnswer> answerList = [
  QuickAnswer(
      'Xin chào', 'Chào mừng tới với demo Flutter app chăm sóc khách hàng'),
  QuickAnswer('Cảm ơn', 'Cảm ơn vì đã mua hàng ở cửa hàng chúng tôi'),
];
