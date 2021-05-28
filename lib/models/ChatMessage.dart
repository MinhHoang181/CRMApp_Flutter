import 'package:flutter/material.dart';

enum ChatMessageType {
  text,
  audio,
  image,
  video,
}

enum MessageStatus {
  not_send,
  not_view,
  viewed,
}

class ChatMessage {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  ChatMessage({
    this.text = '',
    @required this.messageType,
    @required this.messageStatus,
    @required this.isSender,
  });
}
