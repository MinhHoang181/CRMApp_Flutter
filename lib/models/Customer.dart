//Models
import 'Tag.dart';

class Customer {
  String name;
  String phone;
  String address;

  List<Tag> tags = List.empty(growable: true);

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
}
