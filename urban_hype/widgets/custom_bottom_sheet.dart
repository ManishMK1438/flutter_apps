import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:loading_indicator/loading_indicator.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({Key key}) : super(key: key);

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  User _user = FirebaseAuth.instance.currentUser;

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
            maxHeight: 180.0
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Wait!',style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold
              ),),
              Divider(),
              _isLoading ? Container(width: 50.0,height: 50.0,child: LoadingIndicator(indicatorType: Indicator.ballClipRotate)): Text('Are you sure you Want to remove all favourites?',style: TextStyle(
                  fontSize: 18.0
              ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text('NO'),),
                  TextButton(onPressed: (){
                    _isLoading = true;
                    FirebaseFirestore.instance.collection('users/${_user.uid}/favourites/').get().then((snapshot) => {
                      for(DocumentSnapshot ds in snapshot.docs){
                        ds.reference.delete()
                      }
                    });
                    setState(() {
                      _isLoading = false;
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Favourite list has been cleared'),),);
                  }, child: Text('YES'),),
                ],
              ),
            ],
          ),
        )
    );
  }
}
