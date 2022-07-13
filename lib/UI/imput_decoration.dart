import 'package:flutter/material.dart';

class InputDecorations {

  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixicon,
  }) {
    return InputDecoration(
            enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
            color: Colors.orangeAccent)
              ),
            focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
            color: Colors.orangeAccent,
            width: 2,
                )
              ),
            hintText: hintText,
            labelText: labelText,
            labelStyle: const TextStyle(
              color: Colors.grey,
            ),
            prefixIcon: prefixicon != null 
            ? Icon(prefixicon, color: Colors.orangeAccent) 
            : null
            );
}}