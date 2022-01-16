import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urban_hype/widgets/drawer.dart';
import 'package:urban_hype/widgets/product_item_tile.dart';

class FirstScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('products')
              .snapshots(),
          builder: (ctx, productSnapshots) {
            if (productSnapshots.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return GridView.builder(
                padding: EdgeInsets.all(5),
                  itemCount: productSnapshots.data.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0),
                  itemBuilder: (ctx, index) {
                    return ProductItem(productName: productSnapshots.data.docs[index]['productName'],
                    price: productSnapshots.data.docs[index]['price'],
                      url:  productSnapshots.data.docs[index]['imageUrl'],
                      id:  productSnapshots.data.docs[index]['productId'],
                      description:  productSnapshots.data.docs[index]['description'],
                      category:  productSnapshots.data.docs[index]['category'],
                    );
                  });
            }
          },
    );
  }
}
