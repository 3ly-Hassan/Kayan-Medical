import 'package:flutter/material.dart';

ThemeData getLightTheme(context) {
  return ThemeData(
      scaffoldBackgroundColor: const Color.fromARGB(255, 233, 229, 229),
      primaryColor: Colors.red,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: Theme.of(context).textTheme.subtitle1,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.lightGreen,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.0),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ));
}
