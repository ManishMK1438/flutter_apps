import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urban_hype/widgets/favourite_card_tile.dart';

class CartScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users/${_auth.currentUser.uid}/cart').snapshots(),
      builder: (ctx, cartSnapshots){
        if(cartSnapshots.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }else{
          return ListView.builder(
            itemCount: cartSnapshots.data.docs.length,
            itemBuilder: (ctx, index){
              return CardTile(
                productName: cartSnapshots.data.docs[index]['productName'],
                description: cartSnapshots.data.docs[index]['description'],
                price: cartSnapshots.data.docs[index]['price'],
                id: cartSnapshots.data.docs[index]['productId'],
                url: cartSnapshots.data.docs[index]['imageUrl'],
                category: cartSnapshots.data.docs[index]['category'],
              );
            },
          );
        }
      },
    );
  }
}
