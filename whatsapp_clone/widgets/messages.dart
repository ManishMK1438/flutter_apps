import 'package:chat_app_beta/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  //final FirebaseAuth _auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chats').orderBy('createdAt', descending: true).snapshots(),
      builder: (ctx, chatSnapshots){
        if(chatSnapshots.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        }else{
          return ListView.builder(
            reverse: true,
            itemCount: chatSnapshots.data.docs.length,
            itemBuilder: (ctx, index){
              return MessageBubble(message: chatSnapshots.data.docs[index]['text'], uId: chatSnapshots.data.docs[index]['uId'],);
            },
          );
        }
      },
    );
  }
}
