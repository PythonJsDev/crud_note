import 'dart:convert';
import 'package:crud_note_front/models/api_response.dart';
import 'package:crud_note_front/models/note_for_listing.dart';
import 'package:crud_note_front/models/note.dart';
import 'package:crud_note_front/models/note_manipulation.dart';
import 'package:http/http.dart' as http;

class NotesService {
  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(Uri.parse('http://10.0.2.2:8000/notes/')).then(
      (data) {
        if (data.statusCode == 200) {
          final jsonData = json.decode(data.body);
          final notes = <NoteForListing>[];
          for (var item in jsonData) {
            notes.add(NoteForListing.fromJson(item));
          }
          return APIResponse<List<NoteForListing>>(data: notes);
        }
        return APIResponse<List<NoteForListing>>(
            data: <NoteForListing>[],
            error: true,
            errorMessage: 'An error occured');
      },
    ).catchError((_) => APIResponse<List<NoteForListing>>(
        data: <NoteForListing>[],
        error: true,
        errorMessage: 'An error occured'));
  }

  Future<APIResponse<Note>> getNote(String noteId) {
    return http
        .get(Uri.parse('http://10.0.2.2:8000/notes/$noteId'))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Note>(data: Note.fromJson(jsonData));
      }
      return APIResponse<Note>(
          data: null, error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<Note>(
            data: null, error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> createNote(NoteManipulation item) {
    return http
        .post(
      Uri.parse('http://10.0.2.2:8000/notes/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(item.toJson()),
    )
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(
          data: null, error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<bool>(
            data: null, error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> updateNote(String noteId, NoteManipulation item) {
    return http
        .put(
      Uri.parse('http://10.0.2.2:8000/notes/$noteId/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(item.toJson()),
    )
        .then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(
          data: null, error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<bool>(
            data: null, error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> deleteNote(String noteId) {
    return http
        .delete(
      Uri.parse('http://10.0.2.2:8000/notes/$noteId/'),
    )
        .then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(
          data: null, error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<bool>(
            data: null, error: true, errorMessage: 'An error occured'));
  }
}


  