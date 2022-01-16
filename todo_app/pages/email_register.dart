
import 'package:flutter/material.dart';
import 'package:todo_app/domains/repositories/firebase_networking.dart';
import 'package:todo_app/pages/widgets/custom_round_button.dart';
import 'package:todo_app/pages/widgets/custom_text_button.dart';
import 'package:todo_app/pages/widgets/register_page_widgets/custom_text_field.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController _c1 = TextEditingController();
  TextEditingController _c2 = TextEditingController();
  TextEditingController _c3 = TextEditingController();
  TextEditingController _c4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Create Your Account',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextField(
                        obscureText: false,
                          labelText: 'UserName', hintText: 'Enter your username', c1: _c1),
                      CustomTextField(
                        obscureText: false,
                          labelText: 'Email', hintText: 'Enter your email', c1: _c2),
                      CustomTextField(
                        obscureText: true,
                          labelText: 'Password', hintText: 'Enter your password', c1: _c3),
                      CustomTextField(
                        obscureText: false,
                          labelText: 'Phone Number',
                          hintText: 'Enter your phone number',
                          c1: _c4),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                CustomRoundButton(buttonText: 'Register',onPressed: () async{
                  print('********************************************************************************************');
                  print(_c2.text);
                  print(_c3.text);
              //  CustomUser user= CustomUser(password: _c3.text, email: _c2.text);
                  await FirebaseNetworking.registerUser(email: _c2.text, password: _c3.text);

                  print('******************************************************************************************** registered');
                  //FirebaseNetworking(email: _c2.text, password: _c3.text);
                }),
                CustomTextButton(buttonText: 'Already have an account?', onPressed: ()=>
                  Navigator.pop(context)
                ,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
