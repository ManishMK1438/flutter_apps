import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:urban_hype/screens/add_product_screen.dart';
import 'package:urban_hype/screens/categories_screen.dart';
import 'package:urban_hype/screens/details_screen.dart';
import 'package:urban_hype/screens/filter_screen.dart';
import 'package:urban_hype/screens/first_screen.dart';
import 'package:urban_hype/screens/login_screen.dart';
import 'package:urban_hype/screens/register_screen.dart';
import 'package:urban_hype/screens/tabs_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshots){
          if(!snapshots.hasData){
            return LoginScreen();
          }else{
            return TabsScreen();
          }
        },
      ),
      //initialRoute: 'loginScreen',
      routes: {
        'firstScreen' : (ctx) => TabsScreen(),
        'addProductsScreen': (ctx) => AddProduct(),
        'detailsScreen': (ctx) => DetailsScreen(),
        'categoriesScreen': (ctx) => CategoriesScreen(),
        'filterScreen': (ctx) => FilterScreen(),
        'registerScreen': (ctx) => RegisterScreen(),
        'loginScreen': (ctx) => LoginScreen(),
      },
    );
  }
}

