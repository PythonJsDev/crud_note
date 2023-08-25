class NoteForListing {
  final int noteId;
  final String noteTitle;
  final DateTime createDateTime;
  final DateTime lastEditDateTime;

  NoteForListing(
      {required this.noteId,
      required this.noteTitle,
      required this.createDateTime,
      required this.lastEditDateTime});

  factory NoteForListing.fromJson(Map<String, dynamic> item) {
    return NoteForListing(
      noteId: item['id'],
      noteTitle: item['note_title'],
      createDateTime: DateTime.parse(item['create_date_time']),
      lastEditDateTime: item['last_edit_date_time'] != null
          ? DateTime.parse(item['last_edit_date_time'])
          : DateTime.parse(item['create_date_time']),
    );
  }
}
