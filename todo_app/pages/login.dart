import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/domains/models/user.dart';
import 'package:todo_app/domains/services/user_operations.dart';
import 'package:todo_app/pages/email_login.dart';
import 'package:todo_app/pages/email_register.dart';
import 'package:todo_app/pages/first_page.dart';
import 'package:todo_app/utils/api_client.dart';
import 'package:todo_app/utils/config.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:convert' as json_convert;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  late VideoPlayerController _videoPlayerController;
  final FacebookLogin facebookSignIn = new FacebookLogin();


  _loginWithFaceBook() async{
    final FacebookLoginResult result =
    await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        print('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        Future<Response> data = APIClient.getUserDetailsByDIO(token: accessToken.token, userID: accessToken.userId);
        dynamic responseBody;
         data.then((value) {
          responseBody = value.data;

          var data = json_convert.jsonDecode(responseBody);
          User user = User.fromJSON(data);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FirstPage(user: user,)));

          print('############################################');
          print(responseBody.runtimeType);
          print(responseBody);
          print('############################################');
        });



        //Navigator.push(context, MaterialPageRoute(builder: (context) => FirstPage(user: user,)));

        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  _loginWithGoogle() async{
    UserOperations userOperations = UserOperations();
    User user = await userOperations.login();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FirstPage(user: user,)));
    print('___________________________________________________________________________________________________');
    print('User info is $user');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController = VideoPlayerController.network(Config.videoUrl);
    _videoPlayerController.setLooping(true);
    _videoPlayerController.setVolume(0);
    _videoPlayerController.initialize().then((value) => setState((){})).catchError((onError){
      print(onError);
    });
    _videoPlayerController.play();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          VideoPlayer(_videoPlayerController),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login',
                  style: GoogleFonts.pacifico(color: Colors.white,fontSize: 30),
                ),
                SignInButton(Buttons.Google, onPressed: _loginWithGoogle),
                SignInButton(Buttons.FacebookNew, onPressed: (){
                  _loginWithFaceBook();
                }),
                SignInButtonBuilder(backgroundColor: Colors.grey, onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                }, text: 'Sign in with Email',icon: Icons.email,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
