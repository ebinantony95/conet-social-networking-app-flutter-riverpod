import 'package:flutter/material.dart';

class MyTextFormFieldTheme {
  MyTextFormFieldTheme._();

  static final light = InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 2),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
    ),
    hintStyle: const TextStyle(color: Colors.grey),
  );

  static final dark = InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 2),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
    ),
    hintStyle: const TextStyle(color: Colors.grey),
  );
}
