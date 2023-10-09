import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          hintText: 'Title',
          hintStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            HapticFeedback.heavyImpact();
            return 'Title should not be empty';
          } return null;
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
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          hintText: 'Details',
          hintStyle: const TextStyle(fontSize: 16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            HapticFeedback.heavyImpact();
            return 'Details should not be empty';
          } return null;
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