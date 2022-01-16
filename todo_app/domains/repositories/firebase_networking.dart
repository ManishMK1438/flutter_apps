import 'package:firebase_auth/firebase_auth.dart';



class FirebaseNetworking {
  //CustomUser _user = CustomUser();

  static Future<UserCredential> registerUser(
  {required String email, required String password}) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    UserCredential credential = await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((err) {
      print(err);
    });
    return credential;
  }

  static loginUser({required String email, required String password}) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }

  }
}
