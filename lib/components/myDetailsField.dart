import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyDetailsField extends StatefulWidget {
  final TextEditingController controller;

  const MyDetailsField({
    super.key,
    required this.controller
  });

  @override
  State<MyDetailsField> createState() => _MyDetailsFieldState();
}

class _MyDetailsFieldState extends State<MyDetailsField> {
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
