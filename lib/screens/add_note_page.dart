import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor:Theme.of(context).colorScheme.primaryContainer,
        title: Text('Add Note',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon:Icon(Icons.arrow_back_rounded),
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          onPressed: () { Navigator.pop(context); },
        )
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                titleField(),
                detailsField(),
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

  Widget titleField() {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: TextFormField(
        controller: _title,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)
          ),
          hintText: 'Title',
          hintStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Title should not be empty';
          } else {
            return null;
          }
        },
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSecondaryContainer
        ),
        autofocus: true,
        textCapitalization: TextCapitalization.words,
      ),
    );
  }

  Widget detailsField() {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: TextFormField(
        controller: _details,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          hintText: 'Details',
          hintStyle: TextStyle(fontSize: 16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Details should not be empty';
          } else {
            return null;
          }
        },
        style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSecondaryContainer ),
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.multiline,
        maxLines: null,
      ),
    );
  }
}
