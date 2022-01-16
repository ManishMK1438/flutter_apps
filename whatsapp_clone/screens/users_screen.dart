import 'package:chat_app_beta/widgets/all_users_tempelate.dart';
import 'package:chat_app_beta/widgets/recent_chat_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShowUsers extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (ctx,userSnapshots){
          if(userSnapshots.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }else{
            return ListView.builder(
              itemCount: userSnapshots.data.docs.length,
              itemBuilder: (ctx, index) {
                return UserTileTemplate(
                  userName: userSnapshots.data.docs[index]['userName'],
                  about: 'busy',
                  index: index,
                );
              },
            );
          }
        },
      ),
    );
  }
}
