import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/domains/models/user.dart' as userModel;
import 'package:todo_app/domains/repositories/oauth.dart';

class UserOperations{

  Future<userModel.User>login() async{
    OAuth oAuth = OAuth();
    UserCredential userCredential = await oAuth.login();

    User? user = userCredential.user;
    String? name = user?.displayName;
    String? email = user?.email;
    String? photo = user?.photoURL;
    userModel.User userObj = userModel.User(email: email, name: name, photo: photo);
    return userObj;

  }
}