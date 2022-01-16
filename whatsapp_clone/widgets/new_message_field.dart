import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessageField extends StatefulWidget {
  @override
  _NewMessageFieldState createState() => _NewMessageFieldState();
}


class _NewMessageFieldState extends State<NewMessageField> {
  final _controller = new TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var _enteredMessage = '';

  void _sendMessage () {

    _enteredMessage = _controller.text;

   if(_enteredMessage.trim().isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Message cannot be empty')));
      return;
    }

   FirebaseFirestore.instance.collection('chats').add({
     'text' : _enteredMessage,
     'createdAt' : Timestamp.now(),
     'uId' : _auth.currentUser.uid,
   });
   // print(_enteredMessage);
    _controller.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          color: Colors.white,
         // margin: EdgeInsets.all(5),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  textInputAction: TextInputAction.newline,
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Enter a message...',
                  ),
                ),
              ),
              IconButton(icon: Icon(Icons.send), onPressed: _sendMessage, color: Theme.of(context).primaryColor,),
            ],
          ),
        );
  }
}
