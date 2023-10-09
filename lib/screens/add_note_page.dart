import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:notes_final/components/myDetailsField.dart';
import 'package:notes_final/components/myTitleField.dart';

import '../util/note.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _details = TextEditingController();

  _addNote(){
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      Box<Note> box = Hive.box<Note>('notes');
      box.add(Note(title: _title.text, description: _details.text));
      Navigator.of(context).pop();
      final snackBar = SnackBar(
        content: Text('Note Has Been Created',
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary)
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onPrimaryContainer) ,
        backgroundColor:Theme.of(context).colorScheme.primaryContainer,
        title: Text('Create Note',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                MyTitleField(controller: _title,autoFocus: true),
                MyDetailsField(controller: _details)
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addNote,
        elevation: 0,
        icon: const Icon(Icons.save_rounded),
        label: const Text('Save Note', style: TextStyle(fontSize: 16))
      ),
    );
  }
}