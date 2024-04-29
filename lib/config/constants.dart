import 'package:flutter/material.dart';

const double defaultPadding = 16.0;
const customGreen = Color.fromARGB(255, 93, 134, 86);
const errorColor = Color.fromARGB(255, 217, 16, 4);
const kPrimaryColor = Color.fromARGB(255, 6, 79, 138);
const kPrimaryLightColor = Color.fromARGB(255, 238, 236, 236);
final appTheme = ThemeData(
  primaryColor: kPrimaryColor,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
  scaffoldBackgroundColor: Colors.white,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: kPrimaryColor,
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      shape: const StadiumBorder(),
      maximumSize: const Size(double.infinity, 56),
      minimumSize: const Size(double.infinity, 56),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: kPrimaryLightColor,
    iconColor: kPrimaryColor,
    // prefixIconColor: kPrimaryColor,
    contentPadding: EdgeInsets.symmetric(
        horizontal: defaultPadding, vertical: defaultPadding),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide.none,
    ),
  ),
);
const productDetailsTextStyle =
    TextStyle(fontSize: 19, fontWeight: FontWeight.bold);
List<DropdownMenuItem<String>> accountTypeDropdownItems = const [
  DropdownMenuItem(
    value: 'admin',
    child: Text('Admin'),
  ),
  DropdownMenuItem(
    value: 'user',
    child: Text('User'),
  ),
];
