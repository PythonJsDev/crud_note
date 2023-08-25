import 'package:flutter/material.dart';

class NoteDelete extends StatelessWidget {
  const NoteDelete({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Warning'),
      content: const Text("Are you sure you want to delete this note?"),
      actions: [
        TextButton(
          child: const Text('Yes'),
          onPressed :() {
            Navigator.of(context).pop(true);
          },
        ),
        TextButton(
          child: const Text('No'),
          onPressed :() {
            Navigator.of(context).pop(false);
          },
        )
      ],
    );
  }
}