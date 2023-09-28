import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../util/note.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({Key? key, required this.note}) : super(key: key);

  final Note note;

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  void editNote(Note note, String title, String description) {
    note.title = title;
    note.description = description;
    note.save();
  }

  final formKey = GlobalKey<FormState>();
  final _titleEdit = TextEditingController();
  final _detailsEdit = TextEditingController();

  @override
  initState() {
    super.initState();
    _titleEdit.text = widget.note.title;
    _detailsEdit.text=widget.note.description;
  }

  deleteAlert(){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text('Delete Note?'),
          content: const Text('This note will be deleted permanently'),
          actions: [
            TextButton(
              onPressed: (){Navigator.pop(context);},
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: (){
                _deleteNote();
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            )
          ],
        );
      }
    );
  }

  _deleteNote() {
    var notesBox = Hive.box<Note>('notes');
    notesBox.delete(widget.note.key);
    Navigator.pop(context);
    final snackBar = SnackBar(
      content: Text('Note Has Been Deleted',
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _editNote(){
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      editNote(widget.note, _titleEdit.text, _detailsEdit.text);
      Navigator.of(context).pop();
      final snackBar = SnackBar(
          content: Text('Note Has Been Changed',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
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
        title: Text('Note details',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: deleteAlert,
            icon: const Icon(Icons.delete),
            color: Theme.of(context).colorScheme.onPrimaryContainer,)
        ],
        leading: IconButton(
          icon:Icon(Icons.arrow_back_rounded),
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          onPressed: () { Navigator.pop(context); },
        )
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(4),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                titleField(),
                detailsField()
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _editNote,
        // onPressed: () {
        //   final isValid = formKey.currentState!.validate();
        //   if (isValid) {
        //     editNote(widget.note, _titleEdit.text, _detailsEdit.text);
        //     Navigator.of(context).pop();
        //     const snackBar = SnackBar(
        //       content: Text('Note Has Been Changed')
        //     );
        //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //   }
        // },
        elevation: 0,
        label: const Text('Save Note'),
        icon: const Icon(Icons.save_rounded),
      ),
    );
  }

  Widget titleField() {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: TextFormField(
        controller: _titleEdit,
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
          }
          return null;
        },
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSecondaryContainer
        ),
        textCapitalization: TextCapitalization.words,
      ),
    );
  }

  Widget detailsField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _detailsEdit,
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
            return 'Title should not be empty';
          }
          return null;
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