import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final String id;
  final String name;
  final String recentMessage;
  final DateTime time;

  ChatTile({@required this.name, this.recentMessage, this.time, this.id});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30.0,
        backgroundColor: Colors.blue,
      ),
      title: Text(name),
      subtitle: Text(recentMessage),
      trailing: Text(time.toString()),
    );
  }
}
