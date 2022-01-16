import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urban_hype/modals/User.dart';

import 'package:urban_hype/screens/cart_screen.dart';
import 'package:urban_hype/widgets/custom_bottom_sheet.dart';
import 'package:urban_hype/widgets/drawer.dart';
import '../screens/favourites_screen.dart';
import '../screens/first_screen.dart';

class TabsScreen extends StatefulWidget {
  static int selectedTabIndex = 0;
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  final List<Widget> _tabs = [FirstScreen(), FavouritesScreen(), CartScreen()];
  final String _userId = FirebaseAuth.instance.currentUser.uid;

  List<int> _total = [];

  void _tabSelected(int index) {
    setState(() {
      TabsScreen.selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Urban Hype'),
      ),
      drawer: MainDrawer(),
      body: _tabs[TabsScreen.selectedTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        currentIndex: TabsScreen.selectedTabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourites',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
            backgroundColor: Colors.blue,
          ),
        ],
        onTap: _tabSelected,
      ),
      floatingActionButton: Tooltip(
        message: (TabsScreen.selectedTabIndex == 1)? 'Delete all':(TabsScreen.selectedTabIndex == 0)? 'Add new product ' : 'Place order',
        child: FloatingActionButton(
          child: (TabsScreen.selectedTabIndex == 1) ? Icon(Icons.delete) :(TabsScreen.selectedTabIndex == 0) ? Icon(Icons.add) : Icon(Icons.add_shopping_cart),
          onPressed: (TabsScreen.selectedTabIndex == 1)
              ? () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0))),
                      context: context,
                      builder: (ctx) {
                        return CustomBottomSheet();
                      });
                }
              :(TabsScreen.selectedTabIndex == 0) ? () {
                  Navigator.pushNamed(context, 'addProductsScreen');
                } : () async{
             await FirebaseFirestore.instance
                .collection('users/$_userId/cart/').get().then((value) => {
                  value.docs.forEach((element) {

                    _total.add(element['price']);
                  })
             });

             print(_total);

             _total.clear();
          },
        ),
      ),
    );
  }
}
