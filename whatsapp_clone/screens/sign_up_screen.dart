import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../modal classes/user.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  //final focusNode = FocusNode();
  var isLoading = false;

  var _tempUser = CustomUser(
    userId: null,
    email: '',
    userName: '',
    password: '',
  );

  String _passwordValidator;

  Future<void> _onSaved() async {
    FocusScope.of(context).unfocus();

    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();

    isLoading = true;
    String message = 'Sign up Successful!';
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: _tempUser.email, password: _tempUser.password);

      _tempUser = CustomUser(
          userId: result.user.uid,
          email: _tempUser.email,
          userName: _tempUser.userName,
          password: _tempUser.password);

      var fireStoreResult = await FirebaseFirestore.instance.collection('users').doc(result.user.uid).set({
        'userId' : _tempUser.userId,
        'email' : _tempUser.email,
        'password' : _tempUser.password,
        'userName' : _tempUser.userName,
      });

      Navigator.of(context).pop('logIn');

    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
      message = e.toString();
    }

    setState(() {
      isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message == null ? '' : message)));
    });

    /*
    print(_tempUser.email);
    print(_tempUser.password);
    print(_tempUser.userName);
    print(_tempUser.userId);
    FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
      print(event.docs[0]['text']);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 50.0, 0, 50.0),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50.0,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecoration(hintText: 'Enter an Email...'),
                            validator: (value) {
                              if (value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Invalid Email.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              //value entered by user
                              _tempUser = CustomUser(
                                  userId: _tempUser.userId,
                                  email: value,
                                  userName: _tempUser.userName,
                                  password: _tempUser.password);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'Enter Username',
                            ),
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Invalid Username.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              //value entered by user
                              _tempUser = CustomUser(
                                  userId: _tempUser.userId,
                                  email: _tempUser.email,
                                  userName: value,
                                  password: _tempUser.password);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'Enter Password...',
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Password cannot be empty.';
                              }
                              if (value.length < 5) {
                                return 'Password must be atleast 5 characters long.';
                              }
                              _passwordValidator = value;
                              return null;
                            },
                            onSaved: (value) {
                              //value entered by user
                              _tempUser = CustomUser(
                                  userId: _tempUser.userId,
                                  email: _tempUser.email,
                                  userName: _tempUser.userName,
                                  password: value);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Confirm Password...',
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value != _passwordValidator) {
                                return 'Password do not match.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              //value entered by user
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: isLoading ? CircularProgressIndicator() : ElevatedButton(
                    onPressed: () {
                      _onSaved();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      child: Text('Sign Up'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Already have an account? Login here.',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
