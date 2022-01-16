import 'package:flutter/material.dart';
import 'package:todo_app/domains/models/user.dart';
import 'package:todo_app/pages/widgets/first_page_widgets/top_bar.dart';
import 'package:todo_app/pages/widgets/first_page_widgets/user_profile_display.dart';

class Wave extends StatelessWidget {
  final User? user;
  const Wave({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        height: size.height/2,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orangeAccent, Colors.yellowAccent,Colors.amberAccent],
            begin: Alignment.topLeft,end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const TopBar(),
            UserProfileDisplay(user: user),
          ],
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
   var path = Path();
   path.lineTo(0, size.height-50);
   path.quadraticBezierTo(0.20*size.width, size.height, 0.60* size.width,size.height-100);
   path.lineTo(0.60* size.width, size.height-100);
   path.quadraticBezierTo(0.80*size.width, size.height-150,  size.width,size.height-100);
   path.lineTo(size.width, size.height-50);
   path.lineTo(size.width, 0);
   path.close();
   return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

}
