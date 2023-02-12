import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:notes/models/note.dart';

class ApiService {
  static String _baseURL = "https://notesnodeuday.onrender.com/notes";

  static Future<void> addNote(Note note) async {
    Uri requestURI = Uri.parse(_baseURL + "/add");
    var response = await http.post(requestURI, body: note.toMap());
    var decoded = jsonDecode(response.body);
    print(decoded);
  }

  static Future<void> deleteNote(Note note) async {
    Uri requestURI = Uri.parse(_baseURL + '/delete');
    var response = await http.post(requestURI, body: note.toMap());
    var decoded = jsonDecode(response.body);
    print(decoded);
  }

  static Future<List<Note>> fetchNote(String userid) async {
    Uri requestURI = Uri.parse(_baseURL + '/list');
    var response = await http.post(requestURI, body: {'userid': userid});
    var decoded = jsonDecode(response.body);
    print(decoded);
    List<Note> noteList = [];
    for (var notemap in decoded) {
      Note newnote = Note.fromMap(notemap);
      noteList.add(newnote);
    }
    return noteList;
  }
}
