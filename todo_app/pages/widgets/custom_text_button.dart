import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String buttonText;
   final Function() onPressed;
   CustomTextButton({Key? key, required this.buttonText, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(buttonText, style: TextStyle(color: Colors.white, fontSize: 16),),);
  }
}
