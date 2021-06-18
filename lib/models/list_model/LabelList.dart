import 'dart:collection';

import 'package:cntt2_crm/providers/azsales_api/chat_service/label_api.dart';
import 'package:flutter/material.dart';

import '../Label.dart';

class LabelList extends ChangeNotifier {
  Map<String, Label> _list;

  UnmodifiableMapView get map => UnmodifiableMapView(_list);
  List<Label> get list => _list.values.toList();

  void _addList(List<Label> labels) {
    labels.forEach((label) {
      if (!_list.containsKey(label.id)) {
        _list[label.id] = label;
      }
    });
    notifyListeners();
  }

  bool _addLabel(Label label) {
    if (!_list.containsKey(label.id)) {
      _list[label.id] = label;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<LabelList> fetchData() async {
    if (_list == null) {
      _list = new Map<String, Label>();
      _addList(await LabelAPI.fetchAllLabels());
    }
    return this;
  }

  Future<bool> refreshLabels() async {
    final labels = await LabelAPI.fetchAllLabels();
    if (labels != null) {
      _list.clear();
      _addList(labels);
      return true;
    }
    return false;
  }

  Future<bool> createLabel(String name, String color) async {
    Label label = await LabelAPI.createLabel(
      labelName: name,
      labelColor: color,
    );
    if (label != null) {
      final check = _addLabel(label);
      return check;
    }
    return false;
  }

  Future<bool> removeLabel(String id) async {
    if (_list.containsKey(id)) {
      bool check = await LabelAPI.removeLabel(labelId: id);
      if (check) {
        _list.remove(id);
        notifyListeners();
        return true;
      }
    }
    return false;
  }
}
