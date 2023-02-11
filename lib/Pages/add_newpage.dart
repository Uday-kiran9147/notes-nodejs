import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/provider/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewNotePage extends StatefulWidget {
  AddNewNotePage({super.key});

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  FocusNode noteFocus = FocusNode();

  TextEditingController titleController = TextEditingController();

  TextEditingController contentController = TextEditingController();

  void addnewNote() {
    Note newNote = Note(
        id: Uuid().v1(),
        userid: "udaykiran",
        title: titleController.text,
        content: contentController.text,
        datetime: DateTime.now());

    Provider.of<NoteProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => addnewNote(),
          )
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: titleController,
                onSubmitted: (value) {
                  if (value != '') {
                    noteFocus.requestFocus();
                  }
                },
                style: TextStyle(fontSize: 25),
                autofocus: true, // keeps curser at title field by default
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Title"),
              ),
            ),
            Expanded(
              child: TextField(
                controller: contentController,
                focusNode: noteFocus,
                maxLines: null,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Note"),
              ),
            )
          ],
        ),
      )),
    );
  }
}
