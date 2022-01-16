import 'package:flutter/material.dart';

class CustomRoundButton extends StatelessWidget {
  final String buttonText;
  final Function() onPressed;
  const CustomRoundButton({Key? key, required this.buttonText, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      style: ButtonStyle(
       // fixedSize: MaterialStateProperty.all<Size>(const Size(150, 20)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
