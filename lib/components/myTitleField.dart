import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTitleField extends StatefulWidget {
  final TextEditingController controller;
  final bool? autoFocus;

  const MyTitleField({
    super.key,
    required this.controller,
    this.autoFocus = false
  });

  @override
  State<MyTitleField> createState() => _MyTitleFieldState();
}

class _MyTitleFieldState extends State<MyTitleField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          hintText: 'Title',
          hintStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
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
}
