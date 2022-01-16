import 'package:chat_app_beta/widgets/messages.dart';
import 'package:chat_app_beta/widgets/new_message_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
/*  final String userName;

  ChatScreen({this.userName});*/

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
    final userName = routeArgs['userName'];
    return Scaffold(
      appBar: AppBar(
        title: userName != null ? Text(userName) : Text('...'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: [
              DropdownMenuItem(
                value: 'info',
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('Info'),
                    ],
                  ),
                ),
              ),

            ],
            onChanged: (v) {
              if (v == 'info') {

              }
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.grey,
        child: Column(
          children: [
            Expanded(
                child: Messages()
            ),
            NewMessageField(),
          ],
        ),
      ),
    );
  }
}
