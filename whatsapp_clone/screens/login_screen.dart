import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  var isLoading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  String _email;
  String _password;

  void _saveForm() async {
    FocusScope.of(context).unfocus();

    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }

    _formKey.currentState.save();
    isLoading = true;

    String message = 'Login Successful';
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);

      Navigator.pushReplacementNamed(context, 'recentChatsScreen');

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
        print('No user found for that email.');


      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
        print('Wrong password provided for that user.');
      }

    } catch (e) {
      message = e.toString();
      print(e.toString());
    }
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message == null ? '' : message)));
      });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 50.0, 0, 120.0),
                  child: Text(
                    'Welcome Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'Enter an Email...',
                              ),
                              controller: TextEditingController(),
                              validator: (value) {
                                if (value.trim().isEmpty ||
                                    !value.contains('@')) {
                                  return 'Invalid Email';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                //value entered by user
                                _email = value;
                              },
                            ),
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
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText:
                                    'Enter Password... (Atleast 5 characters long)',
                              ),
                              obscureText: true,
                              controller: TextEditingController(),
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return 'Password must not be empty';
                                } else if (value.length < 5) {
                                  return 'Password is too short!';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                //value entered by user
                                _password = value;
                              },
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15.0,
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
                  borderRadius: BorderRadius.circular(25.0),
                  child: isLoading ? CircularProgressIndicator() : ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 30.0),
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    onPressed: () {
                      _saveForm();
                    },
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'signUp');
                  },
                  child: Text(
                    'New User? Click here to Sign up',
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
