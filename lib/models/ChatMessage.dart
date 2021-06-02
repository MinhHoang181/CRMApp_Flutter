import 'dart:collection';

import 'package:flutter/material.dart';

enum AttachmentType {
  none,
  video,
  image,
  file,
  gif,
}

enum MessageType {
  text,
  attachment,
  sticker,
}

enum MessageStatus {
  not_send,
  not_read,
  readed,
}

class Attachment {
  final String id;
  final String mimeType;
  final String name;
  final String url;
  final String reviewUrl;
  final AttachmentType attachmentType;

  Attachment({
    @required this.id,
    @required this.mimeType,
    @required this.name,
    @required this.url,
    @required this.reviewUrl,
    @required this.attachmentType,
  });
}

class Messages extends ChangeNotifier {
  List<ChatMessage> _messages = List.empty(growable: true);

  UnmodifiableListView get messages => UnmodifiableListView(_messages);

  void add(ChatMessage message) {
    _messages.add(message);
    notifyListeners();
  }
}

class ChatMessage {
  final String id;
  final String message;
  final String createdTime;
  final String sticker;
  List<Attachment> attachments = List.empty(growable: true);
  final MessageType messageType;
  MessageStatus messageStatus;
  final bool isSender;

  ChatMessage({
    @required this.id,
    @required this.message,
    @required this.createdTime,
    @required final this.sticker,
    @required final this.attachments,
    @required final this.messageType,
    @required final this.messageStatus,
    @required final this.isSender,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    String _sticker = '';
    List<Attachment> _attachments = List.empty(growable: true);
    bool _isSender = false;
    MessageStatus _messageStatus = MessageStatus.not_read;
    MessageType _messageType = MessageType.text;
    List<dynamic> _tags = json['tags']['data'];
    _tags.forEach((element) {
      if (element['name'] == 'sent') {
        _isSender = true;
      }
      if (element['name'] == 'read') {
        _messageStatus = MessageStatus.readed;
      }
    });

    if (json.containsKey('sticker')) {
      _sticker = json['sticker'];
      _messageType = MessageType.sticker;
    } else if (json.containsKey('attachments')) {
      List<dynamic> list = json['attachments']['data'];
      list.forEach((element) {
        Map<String, dynamic> _attachment = element;
        String _url;
        String _reviewUrl;
        String _mimeType = element['mime_type'];
        AttachmentType _attachmentType = AttachmentType.none;
        if (_attachment.containsKey('video_data')) {
          _url = _attachment['video_data']['url'];
          _reviewUrl = _attachment['video_data']['preview_url'];
          _attachmentType = AttachmentType.video;
        } else if (_attachment.containsKey('image_data')) {
          _url = _attachment['image_data']['url'];
          _reviewUrl = _attachment['image_data']['preview_url'];
          if (_mimeType.contains('gif')) {
            _attachmentType = AttachmentType.gif;
          } else {
            _attachmentType = AttachmentType.image;
          }
        } else if (_attachment.containsKey('file_url')) {
          _url = _attachment['file_url'];
          _reviewUrl = _attachment['file_url'];
          _attachmentType = AttachmentType.file;
        }

        _attachments.add(Attachment(
          id: element['id'],
          mimeType: _mimeType,
          name: element['name'],
          url: _url,
          reviewUrl: _reviewUrl,
          attachmentType: _attachmentType,
        ));
      });
      _messageType = MessageType.attachment;
    }

    return ChatMessage(
      id: json['id'],
      message: json['message'],
      createdTime: json['created_time'],
      sticker: _sticker,
      attachments: _attachments,
      messageType: _messageType,
      messageStatus: _messageStatus,
      isSender: _isSender,
    );
  }
}
