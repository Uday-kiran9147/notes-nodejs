import 'package:flutter/cupertino.dart';

import '../models/note.dart';

class NoteProvider with ChangeNotifier {
  List<Note> notes = [];

  void addNote(Note note) {
    notes.add(note);
    notifyListeners();
  }

  void updateNote() {}
  void deleteNote() {}
}
