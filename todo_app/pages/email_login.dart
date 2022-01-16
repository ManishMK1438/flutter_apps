import 'package:flutter/material.dart';
import 'package:todo_app/domains/repositories/firebase_networking.dart';
import 'package:todo_app/pages/email_register.dart';
import 'package:todo_app/pages/first_page.dart';
import 'package:todo_app/pages/widgets/custom_round_button.dart';
import 'package:todo_app/pages/widgets/custom_text_button.dart';
import 'package:todo_app/pages/widgets/register_page_widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   TextEditingController _c1 = TextEditingController();
   TextEditingController _c2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text('Login', style: TextStyle(color: Colors.white, fontSize: 50),),
                const SizedBox(height: 40,),

                SizedBox(height: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextField(labelText: 'Email', hintText: 'Enter your email...', c1: _c1,obscureText: false,),
                    CustomTextField(labelText: 'Password', hintText: 'Enter your password...', c1: _c2,obscureText: true,),
                  ],
                ),
                ),
                SizedBox(height: 30,),
                CustomRoundButton(buttonText: 'Login',onPressed: () async{
                  print('********************************************************************************************');
                  print(_c1.text);
                  print(_c2.text);
                 await FirebaseNetworking.loginUser(email: _c1.text, password: _c2.text);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> FirstPage()));
                }),
                CustomTextButton(buttonText: 'Don\'t have an account? Sign Up now', onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*
CustomTextButton(buttonText: 'Don\'t have an account? Sign Up now', onPressed: () =>
Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()))
,),*/
