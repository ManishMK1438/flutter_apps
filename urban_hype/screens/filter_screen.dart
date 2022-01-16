import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _routeArgs =
    ModalRoute
        .of(context)
        .settings
        .arguments as Map<String, String>;
    return Scaffold(
        appBar: AppBar(title: Text('Products found'),),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').where('category', isEqualTo: _routeArgs['selectedCategory']).snapshots(),
        builder: (ctx, filterSnapshots){
          if(filterSnapshots.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return GridView.builder(
            padding: EdgeInsets.all(5),
            itemCount: filterSnapshots.data.docs.length,
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
                    final String id = filterSnapshots.data.docs[index]['productId'];
                    final String productName = filterSnapshots.data.docs[index]['productName'];
                    final String url = filterSnapshots.data.docs[index]['imageUrl'];
                    final String price = filterSnapshots.data.docs[index]['price'];
                    final String description = filterSnapshots.data.docs[index]['description'];
                    final String category = filterSnapshots.data.docs[index]['category'];
                    Navigator.pushNamed(context, 'detailsScreen', arguments: {
                      'id' : id,
                      'productName': productName,
                      'url': url,
                      'price': price,
                      'description': description,
                      'category': category,
                    });
                  },
                  child: GridTile(
                    header: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(filterSnapshots.data.docs[index]['productName'],
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    child: Image.network(filterSnapshots.data.docs[index]['imageUrl'],
                      fit: BoxFit.cover,
                    ),
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      leading: Container(
                        width: 60.0,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(filterSnapshots.data.docs[index]['price'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                          ),
                        ),
                      ),
                      title: IconButton(
                        icon: Icon(Icons.favorite_border_outlined),
                        color: Colors.white,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Login first to use this feature')));
                        },
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.shopping_cart),
                        color: Colors.white,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Login first to use this feature')));
                        },
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
