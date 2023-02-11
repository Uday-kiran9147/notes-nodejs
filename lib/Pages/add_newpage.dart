// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'package:notes/models/note.dart';
import 'package:notes/provider/notes_provider.dart';

class AddNewNotePage extends StatefulWidget {
  const AddNewNotePage({
    Key? key,
    required this.isUpdate,
    this.note,
  }) : super(key: key);

  final bool isUpdate;
  final Note? note;

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

  void updateNewNote() {
    widget.note!.title = titleController.text;
    widget.note!.content = contentController.text;
    Provider.of<NoteProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    //previous  Data will automatically be loaded to contentController  when updating the note
    super.initState();
    if (widget.isUpdate) {
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                if (widget.isUpdate) {
                  //update
                  updateNewNote();
                } else {
                  addnewNote();
                }
              })
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
                autofocus: (widget.isUpdate)
                    ? false
                    : true, // keeps curser at title field by default
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
