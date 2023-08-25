import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:crud_note_front/models/note_for_listing.dart';
import 'package:crud_note_front/models/api_response.dart';
import 'package:crud_note_front/screens/note_delete.dart';
import 'package:crud_note_front/screens/note_modify.dart';
import 'package:crud_note_front/services/notes_service.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  NotesService get service => GetIt.I<NotesService>();

  APIResponse<List<NoteForListing>> _apiResponse =
      APIResponse(data: <NoteForListing>[], errorMessage: '');
  bool _isLoading = false;
  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getNotesList();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List of notes')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (_) => const NoteModify(noteId: null),
            ),
          )
              .then((_) {
            _fetchNotes();
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Builder(builder: (context) {
        if (_isLoading) {
          return const CircularProgressIndicator();
        }
        if (_apiResponse.error) {
          return Center(child: Text(_apiResponse.errorMessage));
        }
        return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: ValueKey(_apiResponse.data![index].noteId),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {},
                confirmDismiss: (direction) async {
                  final result = await showDialog(
                    context: context,
                    builder: (_) => const NoteDelete(),
                  );
                  if (result) {
                    final deleteResult = await service.deleteNote(
                        _apiResponse.data![index].noteId.toString());
                    if (mounted) {
                      String message;
                      if (deleteResult.data == true) {
                        message = "The note was deleted succesfully";
                      } else {
                        message = deleteResult.errorMessage;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                      return deleteResult.data;
                    }
                  }
                  return result;
                },
                background: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.only(left: 16),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: ListTile(
                  title: Text(
                    _apiResponse.data![index].noteTitle,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  subtitle: Text(
                    'Last editing on ${formatDateTime(_apiResponse.data![index].lastEditDateTime)}',
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder: (_) => NoteModify(
                                noteId: _apiResponse.data![index].noteId),
                          ),
                        )
                        .then((data) => _fetchNotes());
                  },
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 1,
                color: Colors.green,
              );
            },
            itemCount: _apiResponse.data!.length);
      }),
    );
  }
}
