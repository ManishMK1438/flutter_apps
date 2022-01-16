import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urban_hype/widgets/favourite_card_tile.dart';

class FavouritesScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users/${_auth.currentUser.uid}/favourites/').snapshots(),
      builder: (ctx, favouritesSnapshots) {
        /*if(favouritesSnapshots.hasError){
          return Center(child: Text('Something went wrong!'),);
        }
        else if(!favouritesSnapshots.hasData){
          return Center(child: Text('Your favourite list is empty'),);
        }
        else
        final _snap = FirebaseFirestore.instance
            .collection('users/${_auth.currentUser.uid}/favourites/')
            .where('isFavourite', isEqualTo: true).getDocuments();
        if(_snap.data.length == 0){
          return Center(child: Text('Your favourite list is empty'));
        }*/
        if (favouritesSnapshots.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: favouritesSnapshots.data.docs.length,
              itemBuilder: (ctx, index) {
                return CardTile(
                  productName: favouritesSnapshots.data.docs[index]['productName'],
                  description: favouritesSnapshots.data.docs[index]['description'],
                  price: favouritesSnapshots.data.docs[index]['price'],
                  url: favouritesSnapshots.data.docs[index]['imageUrl'],
                  id: favouritesSnapshots.data.docs[index]['productId'],
                  category: favouritesSnapshots.data.docs[index]['category'],
                );
              },
            ),
          );
        }
      },
    );
  }
}
