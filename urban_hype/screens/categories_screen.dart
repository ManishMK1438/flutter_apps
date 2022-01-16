import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
        builder: (ctx, categoriesSnapshots){
          if(categoriesSnapshots.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return GridView.builder(
            padding: EdgeInsets.all(5),
            itemCount: categoriesSnapshots.data.docs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0),
            itemBuilder: (ctx, index){
              return ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: GestureDetector(
                  onTap: (){
                    final String selectedCategory = categoriesSnapshots.data.docs[index]['category'];
                    Navigator.pushReplacementNamed(context, 'filterScreen', arguments: {
                      'selectedCategory': selectedCategory
                    });
                  },
                  child: GridTile(
                    child: Image.network(categoriesSnapshots.data.docs[index]['url'],
                      fit: BoxFit.cover,
                    ),
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(categoriesSnapshots.data.docs[index]['category'],
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
