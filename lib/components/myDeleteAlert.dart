import 'package:flutter/material.dart';

class MyDeleteAlert extends StatelessWidget {
  final void Function() onDelete;
  final String component;

  const MyDeleteAlert({super.key, required this.onDelete, required this.component});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete $component?'),
      content: Text('This $component will be deleted permanently'),
      actions: [
        TextButton(
          onPressed: (){Navigator.pop(context);},
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: (){
            onDelete();
            Navigator.pop(context);
          },
          child: const Text('Delete'),
        )
      ],
    );
  }
}
