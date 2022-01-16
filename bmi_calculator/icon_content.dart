import 'package:flutter/material.dart';
import 'constants.dart';

class IconContent extends StatelessWidget {
  final String cardText;
  final IconData cardIcon;

  IconContent({@required this.cardText,@required this.cardIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          cardIcon,
          size: 80.0,
        ),
        SizedBox(height: 20),
        Text(
          cardText,
          style: labelTextStyle,
        ),
      ],
    );
  }
}
