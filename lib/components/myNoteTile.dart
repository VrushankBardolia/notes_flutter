import 'package:flutter/material.dart';
import 'package:notes_final/util/note.dart';

import '../screens/edit_note.dart';

class MyNoteTile extends StatelessWidget {
  final Note note;

  const MyNoteTile({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textColor: Theme.of(context).colorScheme.onSecondaryContainer,
        tileColor: Theme.of(context).colorScheme.secondaryContainer,
        title: Text(note.title,
          style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
        ),
        subtitle: Text(note.description,
          style: const TextStyle(fontSize: 16),
          maxLines: 2,
          overflow: TextOverflow.fade,
        ),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EditNotePage(note: note)));
        },
      ),
    );
  }
}
