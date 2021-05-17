//Models
import 'ChatMessage.dart';
import 'Tag.dart';

class Customer {
  String avatar;
  String name;
  String phone;
  String address;

  List<Tag> tags = List.empty(growable: true);
  List<ChatMessage> chatLogs = List.empty(growable: true);

  Customer(String avatar, String name) {
    this.avatar = avatar;
    this.name = name;
  }

  void addTag(Tag tag) {
    if (!tags.contains(tag)) {
      tags.add(tag);
    }
  }

  void removeTag(Tag tag) {
    if (tags.contains(tag)) {
      tags.remove(tag);
    }
  }

  void updateChatLogs(List<ChatMessage> chatLogs) {
    this.chatLogs = chatLogs;
  }
}
