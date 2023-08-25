import 'package:crud_note_front/services/notes_service.dart';
import 'package:flutter/material.dart';
import 'package:crud_note_front/screens/note_list.dart';
import 'package:get_it/get_it.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(
    () => NotesService(),
  );
}

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: NoteList(),
    );
  }
}
