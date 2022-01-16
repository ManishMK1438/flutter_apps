import 'package:flutter/material.dart';

class Library extends StatelessWidget {
  const Library({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueGrey, Colors.black, Colors.black, Colors.blueGrey],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.3,0.7,0.9],
        ),
      ),
    );
  }
}
