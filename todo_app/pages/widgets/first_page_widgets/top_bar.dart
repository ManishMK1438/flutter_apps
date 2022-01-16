import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: (){}, icon: Icon(Icons.menu),),
        Text('Tasks', style: GoogleFonts.pacifico(fontSize: 22),),
        IconButton(onPressed: (){}, icon: Icon(Icons.search),),
      ],
    );
  }
}
