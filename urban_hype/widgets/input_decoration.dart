import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(String hintText, {IconButton iconButton, Icon preIcon}) {
  return InputDecoration(
    fillColor: Colors.white,
    filled: true,
    contentPadding: EdgeInsets.only(left: 15.0, right: 15.0),
    hintText: hintText,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(width: 1),
    ),
    suffixIcon: iconButton,
    prefixIcon: preIcon,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(
        color: Colors.white,
        width: 1.0,
      ),
    ),
  );
}

