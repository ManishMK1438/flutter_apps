import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urban_hype/widgets/input_decoration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;

  String _email;
  String _password;

  bool _isLoading = false;
  bool _isPasswordHidden = true;

  void _logInUser() async{
    FocusScope.of(context).unfocus();
    final _isValid = _key.currentState.validate();
    if(!_isValid){
      return;
    }

    _key.currentState.save();
    _isLoading = true;

    String message = 'Successfully Logged in';
    try{
      await _auth.signInWithEmailAndPassword(email: _email, password: _password);
      Navigator.pushReplacementNamed(context, 'firstScreen');

    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'No user found with this Email';
      }
      else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      }
    }catch(e){
      message = e.toString();
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

    setState(() {
      _isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(10.0),
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50.0,bottom: 50.0),
                  child: Text(
                    'Log In',
                    style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextFormField(
                        decoration: buildInputDecoration(
                          'Email',
                          preIcon: Icon(Icons.alternate_email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value){
                          if(value.trim().isEmpty){
                            return 'Please enter an email';
                          }
                          if(!value.trim().contains('@')){
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        onSaved: (value){
                          _email = value;
                        },
                      ),
                      SizedBox(height: 20.0,),
                      TextFormField(
                        decoration: buildInputDecoration('Password', preIcon: Icon(Icons.lock), iconButton: IconButton(icon: _isPasswordHidden ? Icon(Icons.visibility) : Icon(Icons.visibility_off), onPressed: (){
                          setState(() {
                            _isPasswordHidden = !_isPasswordHidden;
                          });

                        })),
                        obscureText: _isPasswordHidden,
                        validator: (value){
                          if(value.trim().isEmpty){
                            return 'Please enter a password';
                          }
                          return null;
                        },
                        onSaved: (value){
                          _password = value;
                        },
                      ),
                      SizedBox(height: 5.0,),
                      TextButton(
                          onPressed: (){

                          },
                          child: Text('Forgot Password?',style: TextStyle(color: Colors.red, fontSize: 15.0),),),
                    ],
                  ),
                ),
                SizedBox(height: 20.0,),
                _isLoading ? CircularProgressIndicator(): ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0),),),
                  ),
                  onPressed: _logInUser,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('Log In',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, 'registerScreen');
                    },
                    child: Text('Don\'t have an account? Sign Up here')
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
