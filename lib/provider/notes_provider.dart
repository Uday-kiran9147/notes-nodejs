import 'package:flutter/cupertino.dart';
import 'package:notes/services/api_service.dart';

import '../models/note.dart';

class NoteProvider with ChangeNotifier {
  NoteProvider() {
    fetchNote();
  }

  bool isLoading = true;
  List<Note> notes = [];
  List<Note> searchNotes(String searchQuery) {
    return notes
        .where((element) =>
            element.title!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            element.content!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  void sortnotes() {
    notes.sort((first, second) => second.datetime!.compareTo(first.datetime!));
  }

  void addNote(Note note) {
    notes.add(note);
    sortnotes();
    notifyListeners();
    ApiService.addNote(
        note); //add note function call after notifylistener coz to avoid delay in UI
  }

  void updateNote(Note note) {
    int indexofnote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexofnote] = note;
    sortnotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void deleteNote(Note note) {
    int indexofnote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexofnote);
    sortnotes();
    notifyListeners();
    ApiService.deleteNote(note);
  }

  void fetchNote() async {
    notes = await ApiService.fetchNote("udaykiran");
    sortnotes();
    isLoading = false;
    notifyListeners();
  }
}
