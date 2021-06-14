import 'package:cntt2_crm/utilities/datetime.dart';
import 'package:flutter/material.dart';

enum AttachmentType {
  none,
  image,
  sticker,
}

enum MessageType {
  text,
  attachment,
}

class Attachment {
  final String id;
  final String mimeType;
  final String name;
  final String url;
  final String reviewUrl;
  final bool sticker;
  final AttachmentType attachmentType;

  Attachment({
    @required this.id,
    @required this.mimeType,
    @required this.name,
    @required this.url,
    @required this.reviewUrl,
    @required this.sticker,
    @required this.attachmentType,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    AttachmentType attachmentType = AttachmentType.image;
    bool sticker = json['image_data']['render_as_sticker'];
    if (sticker) {
      attachmentType = AttachmentType.sticker;
    }
    return Attachment(
      id: json['_id'],
      mimeType: json['mime_type'],
      name: json['name'],
      url: json['image_data']['url'],
      reviewUrl: json['image_data']['review_url'],
      sticker: sticker,
      attachmentType: attachmentType,
    );
  }
}

class ChatMessage {
  final String id;
  final String message;
  final String createdTime;
  List<Attachment> attachments = List.empty(growable: true);
  final MessageType messageType;
  final bool isSender;

  ChatMessage({
    @required this.id,
    @required this.message,
    @required this.createdTime,
    @required final this.attachments,
    @required final this.messageType,
    @required final this.isSender,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json, String pageId) {
    List<Attachment> attachments = List.empty(growable: true);
    bool isSender = false;
    MessageType messageType = MessageType.text;

    if (json['from']['_id'] == pageId) {
      isSender = true;
    }

    List<dynamic> jsonAttachments = json['attachments'];
    if (jsonAttachments.isNotEmpty) {
      messageType = MessageType.attachment;
      jsonAttachments.forEach((attchament) {
        attachments.add(Attachment.fromJson(attchament));
      });
    }

    return ChatMessage(
      id: json['_id'],
      message: json['message'],
      createdTime: readTimestamp(json['created_time']),
      attachments: attachments,
      messageType: messageType,
      isSender: isSender,
    );
  }
}
