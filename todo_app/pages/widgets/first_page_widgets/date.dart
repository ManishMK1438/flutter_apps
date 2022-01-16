
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class ShowDate extends StatelessWidget {
  const ShowDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime current = DateTime.now();
    initializeDateFormatting('en');
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: Text(DateFormat.yMMMMEEEEd('en').format(current),style: GoogleFonts.merienda(fontSize: 16,fontStyle: FontStyle.italic,color: Colors.white)),
    );
  }
}
