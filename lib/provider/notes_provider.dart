import 'package:flutter/cupertino.dart';

import '../models/note.dart';

class NoteProvider with ChangeNotifier {
  List<Note> notes = [];

  void addNote(Note note) {
    notes.add(note);
    notifyListeners();
  }

  void updateNote(Note note) {
    int indexofnote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexofnote] = note;
    notifyListeners();
  }

  void deleteNote(Note note) {

    int indexofnote=notes.indexOf(notes.firstWhere((element) => element.id ==note.id));
    notes.removeAt(indexofnote);
    notifyListeners();
  }
}
