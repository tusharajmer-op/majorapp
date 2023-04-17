// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class FirebaseAuthMethod {
//   final FirebaseAuth _auth;
//   FirebaseAuthMethod(this._auth);
//
//   Email Signup
//
//   Future<void> signUpWithEmail({
//     required String name,
//     required String email,
//     required String password,
//   }) async {
//     try {
//       await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       await sendEmailVerification();
//     } on FirebaseAuthException catch (exception) {
//       Fluttertoast.showToast(
//           msg: exception.message!,
//           toastLength: Toast.LENGTH_SHORT,
//           timeInSecForIosWeb: 3,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 11.0);
//     }
//   }
//
//  Email Verification
//   Future<void> sendEmailVerification() async {
//     try {
//       _auth.currentUser!.sendEmailVerification();
//       Fluttertoast.showToast(
//           msg: 'Email Verification sent',
//           toastLength: Toast.LENGTH_SHORT,
//           timeInSecForIosWeb: 3,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 11.0);
//     } on FirebaseAuthException catch (e) {
//       Fluttertoast.showToast(
//           msg: e.message!,
//           toastLength: Toast.LENGTH_SHORT,
//           timeInSecForIosWeb: 3,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 11.0);
//     }
//   }
// }
