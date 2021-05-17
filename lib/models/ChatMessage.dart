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

List<ChatMessage> demoChat = new List.from([
  ChatMessage(
    text: 'Hello',
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessage(
    text: 'Chao',
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: true,
  ),
  ChatMessage(
    text: 'How are you',
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessage(
    text: 'Khoe, cam on, con ban',
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: true,
  ),
  ChatMessage(
    text: 'Im fine too',
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: false,
  ),
  ChatMessage(
    text: 'Test 2 line',
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: false,
  ),
  ChatMessage(
    text: 'Test mutill line',
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: false,
  ),
  ChatMessage(
    text: 'Test mutill line',
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: false,
  ),
  ChatMessage(
    text: 'Test mutill line',
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: false,
  ),
  ChatMessage(
    text: 'Test mutill line',
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: false,
  ),
  ChatMessage(
    text: 'Test mutill line',
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: false,
  ),
  ChatMessage(
    text: 'Test mutill line',
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: false,
  ),
  ChatMessage(
    text: 'Test mutill line',
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: false,
  ),
  ChatMessage(
    text: 'Test mutill line',
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: false,
  ),
  ChatMessage(
    text: 'Test mutill line',
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: false,
  ),
].reversed);
