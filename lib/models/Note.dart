import 'package:cntt2_crm/providers/azsales_api/chat_service/note_api.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/utilities/datetime.dart';

class Note extends ChangeNotifier {
  final String id;
  final String conversationId;
  String _text;
  String get text => _text;
  final String createBy;
  final String dateCreate;
  String _dateUpdate;
  String get dateUpdate => _dateUpdate;

  Note({
    @required this.id,
    @required this.conversationId,
    @required this.createBy,
    @required this.dateCreate,
    @required String text,
    String dateUpdate,
  }) {
    this._text = text;
    this._dateUpdate = dateUpdate;
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['_id'],
      conversationId: json['t_1948069482022211'],
      createBy: json['created_by_user']['display_name'],
      dateCreate: readTimestamp(json['date_created']),
      text: json['text'],
      dateUpdate: json['date_updated'] != null
          ? readTimestamp(json['date_updated'])
          : null,
    );
  }

  void _update(Note note) {
    this._text = note.text;
    this._dateUpdate = note.dateUpdate;
    notifyListeners();
  }

  Future<bool> update(String text) async {
    Note note = await NoteAPI.updateNote(
      noteId: this.id,
      text: text,
    );
    if (note != null) {
      if (this.id == note.id) {
        _update(note);
        return true;
      }
    }
    return false;
  }
}
