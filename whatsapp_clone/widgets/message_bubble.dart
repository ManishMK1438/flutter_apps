import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String uId;

  MessageBubble({this.message, this.uId});

  final String _auth = FirebaseAuth.instance.currentUser.uid;

 /* var _maxWidth = 100.0;
  Double _minWidth;*/

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: _auth == uId ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
        // width: _maxWidth > 100.0 ? _minWidth : 100.0,
          constraints: BoxConstraints(
            maxWidth: 200.0,
          ),
          decoration: BoxDecoration(
            color: _auth == uId ? Colors.black : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomRight:  _auth == uId ? Radius.circular(0): Radius.circular(10),
              bottomLeft: _auth == uId ? Radius.circular(10): Radius.circular(0),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message, style: TextStyle(
                color: _auth == uId ? Colors.white : Theme.of(context).accentTextTheme.bodyText1.color,
              ),
              ),
              SizedBox(height: 10,),
              Text('9:20',style: TextStyle(
                color: _auth == uId ? Colors.white : Colors.black,
                fontSize: 10.0,
              ),),
            ],
          ),
        ),
      ],
    );
  }
}
