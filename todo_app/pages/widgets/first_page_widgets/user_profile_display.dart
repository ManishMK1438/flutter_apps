import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/domains/models/user.dart';

class UserProfileDisplay extends StatelessWidget {
  final User? user;
  const UserProfileDisplay({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 150,
          height: 150,
          margin: const EdgeInsets.only(top: 10,bottom: 10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.blue, width: 2),
            image: DecorationImage(image: NetworkImage(user?.photo ?? ''),fit: BoxFit.contain),
          ),
        ),
        Text('Hello, Manish',style: GoogleFonts.merienda(fontSize: 20),),
        Text('Here are your tasks',style: GoogleFonts.merienda(fontSize: 16),)
      ],
    );
  }
}
