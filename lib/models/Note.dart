import 'package:cntt2_crm/providers/azsales_api/chat_service/note_api.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/utilities/datetime.dart';

import 'list_model/NoteList.dart';

class Note extends ChangeNotifier {
  NoteList noteList;
  final String id;
  final String conversationId;
  String _text;
  String get text => _text;
  final String createBy;
  final int timeCreate;
  final String dateCreate;
  String _dateUpdate;
  String get dateUpdate => _dateUpdate;
  int _timeUpdate;
  int get timeUpdate => _timeUpdate;

  Note({
    @required this.id,
    @required this.conversationId,
    @required this.createBy,
    @required this.dateCreate,
    @required this.timeCreate,
    @required String text,
    String dateUpdate,
    @required int timeUpdate,
  }) {
    this._text = text;
    this._dateUpdate = dateUpdate;
    this._timeUpdate = timeUpdate;
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['_id'],
      conversationId: json['t_1948069482022211'],
      createBy: json['created_by_user']['display_name'],
      dateCreate: readTimestampDM(json['date_created']),
      timeCreate: json['date_created'],
      text: json['text'],
      dateUpdate: json['date_updated'] != null
          ? readTimestampDM(json['date_updated'])
          : null,
      timeUpdate: json['date_updated'],
    );
  }

  void _update(Note note) {
    this._text = note.text;
    this._dateUpdate = note.dateUpdate;
    this._timeUpdate = note.timeUpdate;
    notifyListeners();
    noteList.noteUpdateNotify();
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
