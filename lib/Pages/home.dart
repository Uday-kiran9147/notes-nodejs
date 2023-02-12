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
  String search = "";
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Notes"),
          centerTitle: true,
        ),
        body: (!value.isLoading)
            ? (value.notes.length > 0)
                ? SafeArea(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (val) => setState(() {
                              search = val;
                            }),
                            decoration: InputDecoration(hintText: "search"),
                          ),
                        ),
                        (value.searchNotes(search).length > 0)
                            ? GridView.builder(
                                physics:
                                    NeverScrollableScrollPhysics(), //GridView.builder never scrolls but ListView does here.
                                shrinkWrap:
                                    true, //for gridview or listview.builder we have to give predefined size so that it takes all that space shrinkwrap==true does is fits the .builders according to length of its children
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemCount: value.searchNotes(search).length,
                                itemBuilder: (context, index) {
                                  Note CurrentNote =
                                      value.searchNotes(search)[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  AddNewNotePage(
                                                    isUpdate: true,
                                                    note: CurrentNote,
                                                  )));
                                    },
                                    onLongPress: () {
                                      //delete
                                      value.deleteNote(CurrentNote);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: Colors.grey, width: 2)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            value.notes[index].title!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.grey.shade100,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Text(value.notes[index].content!,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 5,
                                              style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontSize: 18)),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "No search data found !!",
                                  textAlign: TextAlign.center,
                                ),
                              )
                      ],
                    ),
                  )
                : Center(
                    child: Text("Notes is Empty !!  "),
                  )
            : Center(
                child: CircularProgressIndicator(
                    color: CupertinoDynamicColor(
                        color: Colors.blue.shade100,
                        darkColor: Colors.grey,
                        highContrastColor: Colors.blueAccent,
                        darkHighContrastColor: Colors.blueAccent,
                        elevatedColor: Colors.blueAccent,
                        darkElevatedColor: Colors.blueAccent,
                        highContrastElevatedColor: Colors.blueAccent,
                        darkHighContrastElevatedColor: Colors.blueAccent)),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => AddNewNotePage(
                          isUpdate: false,
                        )))
          },
          child: const Icon(
            Icons.add,
          ),
          backgroundColor: Colors.brown,
        ),
      ),
    );
  }
}
