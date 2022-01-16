import 'package:flutter/material.dart';
import 'constants.dart';


class BottomButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  BottomButton({@required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        color: Colors.red,
        width: double.infinity,
        height: bottomContainerHeight,
      ),
    );
  }
}
