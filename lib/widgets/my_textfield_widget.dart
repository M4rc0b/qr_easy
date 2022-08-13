import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/styles.dart';

class MyTextField extends StatefulWidget {
  final Function(String) onChanged;
  final String hintText;

  const MyTextField(
      {Key? key, required this.onChanged, this.hintText = "Enter a value"})
      : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: widget.hintText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Styles.grey, width: 1.0),
        ),
      ),
      onChanged: widget.onChanged,
    );
  }
}
