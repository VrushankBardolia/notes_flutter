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
  
  changeThemeSheet(){
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context){
        return Container(
          height: 240,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Change Theme",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onBackground
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.light_mode_rounded),
                  title: const Text("Light Mode"),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.dark_mode_rounded),
                  title: const Text("Dark Mode"),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.phone_android_rounded),
                  title: const Text("System Theme"),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  _showDrawer(){
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Vrushank Bardolia',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            accountEmail: Text('vrushank1793@gmail.com',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text('VB',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontSize: 24
                )
              ),
            ),
          ),
          // const Padding(
          //   padding: EdgeInsets.all(16),
          //   child: Text('This app is Made by\n'
          //       'VRUSHANK BARDOLIA\n\n'
          //       'For the Minor Project Of BCA Sem-5',
          //     style: TextStyle(
          //       fontSize: 20
          //     ),
          //   ),
          // )
        ],
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
        actions: [
          IconButton(
            onPressed: changeThemeSheet,
            icon: const Icon(Icons.color_lens_rounded)
          )
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Note>('notes').listenable(),
          builder: (context, Box<Note> box, _) {
            if (box.isEmpty) {
              return const Center(child: Text('You haven\'t added any notes yet!'));
            }
            return noteList(box);
          }
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        icon: const Icon(Icons.add),
        label: Text('Add Note',
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
}
