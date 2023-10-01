import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../util/note.dart';
import '../screens/add_note_page.dart';
import '../screens/edit_note.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  Widget noteList(Box<Note> box){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 4),
      child: ListView.builder(
          reverse: true,
          shrinkWrap: true,
          itemCount: box.length,
          itemBuilder: (context,index){
            final note = box.getAt(index);
            return Padding(
              padding: const EdgeInsets.all(8),
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                textColor: Theme.of(context).colorScheme.onSecondaryContainer,
                tileColor: Theme.of(context).colorScheme.secondaryContainer,
                title: Text(note!.title,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // drawer: _showDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onPrimaryContainer) ,
        backgroundColor:Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
        title: Text('Note It',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.w600,
            fontSize: 26
          ),
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Note>('notes').listenable(),
          builder: (context, Box<Note> box, _) {
            if (box.isEmpty) {
              return Center(
                  child: Text('No notes are available 🙃\nWhy Don\'t you Create Note? 👇',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 16
                    ),
                  )
              );
            }
            return noteList(box);
          }
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        icon: const Icon(Icons.add),
        label: Text('Create Note',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onPrimaryContainer
          ),
        ),
        onPressed: () {
          HapticFeedback.mediumImpact();
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddNotePage()));
        },
      ),
    );
  }
}
