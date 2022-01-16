
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urban_hype/widgets/custom_alert_dialog.dart';

class MainDrawer extends StatelessWidget {
  final User _auth = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              height: 140.0,
              width: double.infinity,
              color: Colors.yellowAccent,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('User Name'),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Categories'),
              onTap: () {
                Navigator.pushNamed(context, 'categoriesScreen');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('Discount'),
            ),
            Divider(),
            _auth == null ? Container() :ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return CustomAlertDialog();

              });
              }),
          ],
        ),
      ),
    );
  }
}
