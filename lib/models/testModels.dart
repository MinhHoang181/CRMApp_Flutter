import 'package:flutter/material.dart';

import 'ChatMessage.dart';
import 'Customer.dart';
import 'Tag.dart';
import 'QuickAnswer.dart';

final List<Tag> tagsList = [
  Tag(name: 'Khách VIP', color: Colors.red),
  Tag(name: 'Khách Lẻ', color: Colors.yellow),
  Tag(name: 'Khách Buôn', color: Colors.green),
];
final Customer testCustomer = new Customer(
    'https://scontent.fhan5-5.fna.fbcdn.net/v/t1.6435-9/127647065_2858040844461205_173329872841937354_n.jpg?_nc_cat=107&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=LLyCWOvZgM4AX83eZ1X&_nc_ht=scontent.fhan5-5.fna&oh=0726dc574cf53b851efdc413d91ceaa9&oe=60C6FA86',
    'Lê Thanh Tú')
  ..addTag(tagsList[0])
  ..addTag(tagsList[2]);

final List<QuickAnswer> answerList = [
  QuickAnswer(
      'Xin chào', 'Chào mừng tới với demo Flutter app chăm sóc khách hàng'),
  QuickAnswer('Cảm ơn', 'Cảm ơn vì đã mua hàng ở cửa hàng chúng tôi'),
];
