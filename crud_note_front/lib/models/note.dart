class Note {
  final int noteId;
  final String noteTitle;
  final String noteContent;
  final DateTime createDateTime;
  final DateTime lastEditDateTime;

  Note(
      {required this.noteId,
      required this.noteTitle,
      required this.noteContent,
      required this.createDateTime,
      required this.lastEditDateTime});


 factory Note.fromJson(Map<String, dynamic> item) {
    return Note(
      noteId: item['id'],
      noteTitle: item['note_title'],
      noteContent: item['note_content'],
      createDateTime: DateTime.parse(item['create_date_time']),
      lastEditDateTime: item['last_edit_date_time'] != null
          ? DateTime.parse(item['last_edit_date_time'])
          : DateTime.parse(item['create_date_time']),
    );
  }
}