import 'package:flutter/material.dart';

class UserTileTemplate extends StatelessWidget {
  final String userName;
  final String about;
  final int index;

  UserTileTemplate({this.userName, this.about, this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30.0,
        backgroundColor: Colors.blue,
      ),
      title: Text(userName),
      subtitle: Text(about),
      onTap: () {
       //Navigator.pop(context);
        Navigator.pushNamed(context, 'chatScreen', arguments: {
          'userName': userName,
        });
      },
    );
  }
}
