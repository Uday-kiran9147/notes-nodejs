import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Pages/home.dart';
import 'provider/notes_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => NoteProvider())],
      child: const MaterialApp(home: HomePage()),
    );
  }
}
