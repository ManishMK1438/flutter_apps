import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chat_app_beta/modal%20classes/chat.dart';
import 'package:chat_app_beta/widgets/recent_chat_tile.dart';
import 'package:chat_app_beta/widgets/status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/all_users_tempelate.dart';
import 'package:flutter/material.dart';

class RecentChatsScreen extends StatefulWidget {
  @override
  _RecentChatsScreenState createState() => _RecentChatsScreenState();
}

class _RecentChatsScreenState extends State<RecentChatsScreen> {

  var _recentMessage = FirebaseFirestore.instance.collection('chats').orderBy('createdAt', descending: true).limitToLast(1).get();
  List<Chat> _recentChats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: [
              DropdownMenuItem(
                value: 'search',
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('Search'),
                    ],
                  ),
                ),
              ),
              DropdownMenuItem(
                value: 'logOut',
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('Log Out'),
                    ],
                  ),
                ),
              ),
            ],
            onChanged: (v) {
              if (v == 'logOut') {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed('logIn');
                print('logout');
              }
              if(v == 'search') {
                print('search button pressed');
              }
            },
          ),
        ],
      ),

      body: ListView(children: [
        Container(
          color: Colors.grey[200],
          height: 60.0,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return Row(
                    children: [
                      Story(),
                      SizedBox(
                        width: 10.0,
                      ),
                    ],
                  );
                }),
          ),
        ),
        Container(
          child: Divider(
            color: Colors.black,
          ),
          color: Colors.grey[200],
        ),
        Container(
          height: 600,
          color: Colors.grey[200],
          child: Padding(
            padding: EdgeInsets.only(top: 0.0),
            child: StreamBuilder(
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
                        about: 'Busy',
                        index: index,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ]),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'usersScreen');
        },
      ),
    );
  }
}
