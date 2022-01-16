import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;
  final TextEditingController c1;
  const CustomTextField({Key? key, required this.labelText, required this.hintText, required this.c1,required this.obscureText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: c1,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        //focusColor: Colors.white,
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
         // borderSide: const BorderSide(color: Colors.black, width: 1),
        ),
      ),
    );
  }
}
