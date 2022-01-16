import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  final String id;
  final String productName;
  final String url;
  final String price;
  final String description;
  final String category;


  ProductItem(
      {this.id, this.url, this.price, this.productName, this.description, this.category});

  @override
  _ProductItemState createState() => _ProductItemState();
}


class _ProductItemState extends State<ProductItem> {


  User _user = FirebaseAuth.instance.currentUser;

  bool _isFavourite = false;
  bool _isInCart = false;

  bool dataReceive = false;


  void _addFavourite()async{
    setState(() {
      _isFavourite =! _isFavourite;

    });

      try {
        await FirebaseFirestore.instance.collection('users/${_user.uid}/favourites/').doc('${widget.id}').set(
            {
              'isFavourite': _isFavourite,
              'productId': widget.id,
              'category': widget.category,
              'imageUrl': widget.url,
              'description' : widget.description,
              'productName' : widget.productName,
              'price' : widget.price,

            });

      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    /* FirebaseFirestore.instance.collection('users/${_user.uid}/favourites/').snapshots().listen((event) {
       event.docs.forEach((element) {
         print(element['isFavourite']);
       });
      });*/
  }

  void _addToCart()async{
    setState(() {
      _isInCart = true;
    });

    try {
      await FirebaseFirestore.instance.collection('users/${_user.uid}/cart/').doc('${widget.id}').set(
          {
            'isFavourite': _isFavourite,
            'productId': widget.id,
            'category': widget.category,
            'imageUrl': widget.url,
            'description' : widget.description,
            'productName' : widget.productName,
            'price' : widget.price,

          });

    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void check()async{
    await  FirebaseFirestore.instance.collection('users/${_user.uid}/favourites/').doc('${widget.id}').get().then((value) => {

    });
  }
 


  @override
  Widget build(BuildContext context) {

    check();

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        color: Colors.grey[300],
        child: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, 'detailsScreen', arguments: {
              'id' : widget.id,
              'productName': widget.productName,
              'url': widget.url,
              'price': widget.price,
              'description': widget.description,
              'category': widget.category,
            });
          },
          child: GridTile(
            header: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(widget.productName,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            child: Image.network(widget.url,
              fit: BoxFit.cover,
            ),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              leading: Container(
                width: 60.0,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(widget.price,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
              ),
              title: IconButton(
                icon: Icon(dataReceive  ? Icons.favorite : Icons.favorite_border_outlined),
                color: dataReceive  ? Colors.red : Colors.white,
                onPressed: _addFavourite,
              ),
              trailing: IconButton(
                icon: Icon(_isInCart ? Icons.shopping_cart : Icons.shopping_cart_outlined),
                color: Colors.white,
                onPressed: _addToCart,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
