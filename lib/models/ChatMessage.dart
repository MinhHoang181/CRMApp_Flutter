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
  String id;
  String mimeType;
  String name;
  String url;
  String reviewUrl;
  bool sticker;
  AttachmentType attachmentType;

  Attachment({
    this.id,
    this.mimeType,
    this.name,
    this.url,
    this.reviewUrl,
    this.sticker,
    this.attachmentType,
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
  String id;
  String message;
  String dateCreated;
  int timeCreated;
  List<Attachment> attachments = List.empty(growable: true);
  final MessageType messageType;
  final bool isSender;
  bool isUpdate;

  ChatMessage({
    this.id,
    @required this.message,
    this.dateCreated,
    this.timeCreated,
    this.attachments,
    @required this.messageType,
    @required this.isSender,
    this.isUpdate = true,
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
      dateCreated: readTimestamp(json['created_time']),
      timeCreated: json['created_time'],
      attachments: attachments,
      messageType: messageType,
      isSender: isSender,
    );
  }

  void update(ChatMessage message) {
    if (isUpdate == false) {
      this.id = message.id;
      this.dateCreated = message.dateCreated;
      this.timeCreated = message.timeCreated;
      this.attachments = message.attachments;
      isUpdate = true;
    }
  }
}
