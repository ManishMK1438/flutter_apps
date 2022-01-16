import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/tabs_screen.dart';

class CardTile extends StatelessWidget {
  final String id;
  final String productName;
  final String description;
  final String url;
  final String price;
  final String category;

  CardTile({this.id,this.price, this.productName, this.description, this.url, this.category});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _removeFavourites(BuildContext context) async{
    try {
      final result = await FirebaseFirestore.instance.collection(
          'users/${_auth.currentUser.uid}/favourites/').doc('$id').delete();
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void _clearCart(BuildContext context) async{
    try {
      FirebaseFirestore.instance.collection('users/${_auth.currentUser.uid}/cart/').doc('$id').delete();
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      //color: Colors.blueAccent[100],
      elevation: 15.0,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: IconButton(icon: Icon(Icons.delete,color: Colors.redAccent,size: 30.0,),
                onPressed: () => TabsScreen.selectedTabIndex == 1 ?_removeFavourites(context) : _clearCart(context)) ,
            title: Text(productName,overflow: TextOverflow.ellipsis,),
            subtitle: Text(description,overflow: TextOverflow.ellipsis,),
            trailing: Text(price,style: TextStyle(fontSize: 20.0),),
          ),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, 'detailsScreen',arguments: {
                'productName' : productName,
                'description': description,
                'price': price,
                'url': url,
                'id': id,
                'category': category,
              });
            },
            child: Container(
              height: 200.0,
              width: double.infinity,
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed:(){

                    },
                    child: Text(
                      'Remove Favourite',
                      style: TextStyle(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {

                    },
                    child: Text('Add to Cart!'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
