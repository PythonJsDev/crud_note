import 'package:crud_note_front/models/note_manipulation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:crud_note_front/services/notes_service.dart';
import 'package:crud_note_front/models/note.dart';

class NoteModify extends StatefulWidget {
  const NoteModify({super.key, required this.noteId});

  final int? noteId;

  @override
  State<NoteModify> createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.noteId != null;
  NotesService get notesService => GetIt.I<NotesService>();

  String? errorMessage;
  Note? note;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      notesService.getNote(widget.noteId.toString()).then((response) {
        setState(() {
          _isLoading = false;
        });
        if (response.error) {
          errorMessage = response.errorMessage;
        }
        note = response.data;
        _titleController.text = note!.noteTitle;
        _contentController.text = note!.noteContent;
      });
    }
  }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit note' : 'Create note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(hintText: "Note title"),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _contentController,
                    decoration: const InputDecoration(hintText: "Note content"),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.purple,
                    ),
                    onPressed: () async {
                      if (isEditing) {
                        setState(() {
                          _isLoading = true;
                        });
                        final note = NoteManipulation(
                            noteTitle: _titleController.text,
                            noteContent: _contentController.text);
                        final result = await notesService.updateNote(widget.noteId.toString(), note);
                        setState(() {
                          _isLoading = false;
                        });
                         const title = 'Done';
                        final text = result.error
                            ? result.errorMessage
                            : "your note was updated";
                        if (!mounted) return;
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text(title),
                            content: Text(text),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Ok'),
                              )
                            ],
                          ),
                        ).then((data){
                          if (result.data!) {
                            Navigator.of(context).pop();
                          }
                        });

                      } else {
                        setState(() {
                          _isLoading = true;
                        });
                        final note = NoteManipulation(
                            noteTitle: _titleController.text,
                            noteContent: _contentController.text);
                        final result = await notesService.createNote(note);
                        setState(() {
                          _isLoading = false;
                        });
                        const title = 'Done';
                        final text = result.error
                            ? result.errorMessage
                            : "your note was created";
                        if (!context.mounted) return;
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text(title),
                            content: Text(text),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Ok'),
                              )
                            ],
                          ),
                        ).then((data){
                          if (result.data!) {
                            Navigator.of(context).pop();
                          }
                        });

                    }
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
      ),
    );
  }
}
