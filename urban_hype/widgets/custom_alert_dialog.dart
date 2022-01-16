import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({Key key}) : super(key: key);

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('WAIT'),
      content:_isLoading ? Container(width:40.0,height: 40.0,child: LoadingIndicator(indicatorType: Indicator.ballClipRotate)) : Text('Are you sure you want to log out?'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      actions: _isLoading ? []: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('No')),
        TextButton(
            onPressed: () {
              _isLoading = true;
             FirebaseAuth.instance.signOut();
              setState(() {
                _isLoading = false;
              });
              Navigator.popAndPushNamed(context, 'loginScreen');
            },
            child: Text('Yes')),
      ],
    );

  }
}
