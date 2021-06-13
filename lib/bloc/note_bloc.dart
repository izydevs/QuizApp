import 'dart:async';

import 'package:quiz_app/database/datebase_helper.dart';
import 'package:quiz_app/database/note_model.dart';
import 'package:rxdart/subjects.dart';

class NoteBloc {
  NoteBloc();

  DatabaseHelper helper = DatabaseHelper.instance;
  final _notes = BehaviorSubject<List<NoteModel>>();
  StreamSink<List<NoteModel>> get notesSink => _notes.sink;
  Stream<List<NoteModel>> get notes => _notes.stream;


  Future<void> addNote(NoteModel note) async {
    try {
      await helper.insert(note);
    } catch (e) {
      print(e);
    }
  }
  Future<void> getNotes() async {
    try {
      await helper.queryNotes().then((value) {
        _notes.add(value);
      });
    } catch (e) {
      print(e);
    }
  }
}
