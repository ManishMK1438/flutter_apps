
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urban_hype/widgets/input_decoration.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _key = GlobalKey<FormState>();
  String _userName;
  String _email;
  String _password;

  String _passwordValidator;
  bool _isPasswordHidden = true;
  bool _isLoading = false;

  void _registerUser() async {
    FocusScope.of(context).unfocus();
    final _isValid = _key.currentState.validate();
    if(!_isValid){
      return;
    }
    _key.currentState.save();

    _isLoading = true;
    String message = 'Signed up successfully';

    try {
      UserCredential _result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email, password: _password);

      await FirebaseFirestore.instance.collection('users').doc(_result.user.uid).set({
        'userId': 01,
        'userName': _userName,
        'email': _email,
        'password': _password
      });

    }on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
    } catch (e) {
      print(e);
      message = e.toString();
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 50.0, 0, 20.0),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      Container(
                        child: TextFormField(
                          decoration: buildInputDecoration('Username',preIcon: Icon(Icons.account_circle)),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return 'Please enter a username';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _userName = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          decoration: buildInputDecoration('Email',preIcon: Icon(Icons.alternate_email)),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return 'Please enter an Email';
                            }
                            if (!value.trim().contains('@')) {
                              return 'Please enter a valid Email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _email = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        child: TextFormField(
                          decoration: buildInputDecoration(
                              'Password (Atleast 5 characters)',preIcon: Icon(Icons.lock),iconButton: IconButton(icon: _isPasswordHidden == true ? Icon(Icons.visibility) : Icon(Icons.visibility_off), onPressed: () {
                                setState(() {
                                  _isPasswordHidden = !_isPasswordHidden;
                                });
                          }),
                          ),
                          textInputAction: TextInputAction.next,
                          obscureText: _isPasswordHidden,
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return 'Please enter a password ';
                            }
                            if (value.trim().length < 5) {
                              return 'Please enter atleast 5 characters';
                            }
                            _passwordValidator = value;
                            return null;
                          },
                          onSaved: (value) {
                            _password = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        child: TextFormField(
                          decoration: buildInputDecoration('Confirm Password',preIcon: Icon(Icons.lock),iconButton: IconButton(icon: _isPasswordHidden == true ? Icon(Icons.visibility) : Icon(Icons.visibility_off), onPressed: (){
                            setState(() {
                              setState(() {
                                _isPasswordHidden =! _isPasswordHidden;
                              });
                            });


                          })),
                          obscureText: _isPasswordHidden,
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value.trim() != _passwordValidator) {
                              return 'Password do not match!';
                            }

                            return null;
                          },
                          onSaved: (value) {},
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      _isLoading ? CircularProgressIndicator() : ElevatedButton(
                        onPressed: _registerUser,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Sign UP',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, 'loginScreen');
                        },
                        child: Text('Already have an account? Login here'),
                      ),
                    ],
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
