class NoteManipulation {
  final String noteTitle;
  final String noteContent;

  NoteManipulation({required this.noteTitle, required this.noteContent});

  Map<String, dynamic> toJson() {
    return {
      "note_title": noteTitle,
      "note_content": noteContent,
    };
  }
}
