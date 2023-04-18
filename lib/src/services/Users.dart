import 'package:firebase_auth/firebase_auth.dart';

class users {
  var auth = FirebaseAuth.instance;
  Future<String> signupUser(String email, String password) async {
    try {
      print(email);
      print(password);
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        print(value.credential);
        return "Account Created Successfully";
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }

    
      return "invalid credential plese check you email id and password";
    } catch (e) {
      return 'some error occured! please try later';
    }
  }

  Future<String> login(String email, String password) async {
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        print(value.additionalUserInfo);
        return "Logged In Successfully";
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return "invalid credentials please check your email and password";
    }
  }
}
