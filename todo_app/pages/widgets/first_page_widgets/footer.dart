import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.redAccent,
      child: Text('Powerwd by Brain Mentors', style: GoogleFonts.pacifico(color: Colors.white, fontStyle: FontStyle.italic,fontSize: 18),),
    );
  }
}
