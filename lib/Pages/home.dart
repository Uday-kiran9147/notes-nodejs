import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/Pages/add_newpage.dart';
import 'package:notes/provider/notes_provider.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Notes /"),
          centerTitle: true,
        ),
        body: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: value.notes.length,
            itemBuilder: (context, index) {
              Note CurrentNote = value.notes[index];
              return GestureDetector(
                onTap: () {},
                onLongPress: () {
                  //delete
                  value.deleteNote(CurrentNote);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey, width: 2)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value.notes[index].title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(value.notes[index].content!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 18)),
                    ],
                  ),
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => AddNewNotePage()))
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
