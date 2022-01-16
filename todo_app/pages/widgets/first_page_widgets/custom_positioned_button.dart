import 'package:flutter/material.dart';

class CustomPositionedButton extends StatelessWidget {
  double? right;
  double? left;
  double? top;
  double? bottom;
  IconData icon;
  Function() onPressed;
   CustomPositionedButton({Key? key,this.top, this.bottom, this.left, this.right, required this.icon, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: right,
      top: top,
      bottom: bottom,
      left: left,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.redAccent,
          shape: BoxShape.circle,
        ),
        child: IconButton(onPressed: onPressed, icon: Icon(icon)),
      ),
    );
  }
}
