import 'package:firebase_auth/firebase_auth.dart';
import 'package:backgroundgeolocationfirebaseexample/screens/login/phone_auth/enter_code.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAuth auth = FirebaseAuth.instance;
SharedPreferences sharedPreferences;

Future<String> registerUser({
  String displayName,
  String email,
  String password,
}) async {
  String _errorMessage;
  User _user;
  try {
    _user = (await auth.createUserWithEmailAndPassword(
        email: email, password: password))
        .user;

    _user.updateProfile(displayName: displayName);
    _user.sendEmailVerification();
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      _errorMessage = 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      _errorMessage = 'The account already exists for that email.';
    } else if (e.code == 'invalid-email') {
      _errorMessage = 'The email address is badly formatted.';
    } else {
      _errorMessage = e.message;
    }
  }

  if (_errorMessage != null) {
    return _errorMessage;
  }

  return 'Register success!';
}

Future<String> signInWithEmail({
  String email,
  String password,
}) async {
  String _errorMessage;
  User _user;
  sharedPreferences = await SharedPreferences.getInstance();
  try {
    _user = (await auth.signInWithEmailAndPassword(
        email: email, password: password))
        .user;
    sharedPreferences.setBool('isLogin', true);
    sharedPreferences.setString('displayName', _user.displayName);
    sharedPreferences.setString('email', _user.email);
    sharedPreferences.setBool('isVerified', _user.emailVerified);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      _errorMessage = 'No user found with the credential.';
    } else if (e.code == 'wrong-password') {
      _errorMessage = 'The password is wrong.';
    } else if (e.code == 'invalid-email') {
      _errorMessage = 'The email address is badly formatted.';
    } else {
      _errorMessage = e.message;
    }
  }

  if (_errorMessage != null) {
    return _errorMessage;
  }

  return 'Login success!';
}

Future<String> resetPassword({String email}) async {
  String _errorMessage;
  try {
    await auth.sendPasswordResetEmail(email: email);
  } on FirebaseAuthException catch (e) {
    _errorMessage = e.message;
  }

  if (_errorMessage != null) {
    return _errorMessage;
  }

  return 'Success!';
}

Future<void> sendVerification() async {
  User user = auth.currentUser;
  await user.sendEmailVerification();
}

Future<void> signOut() async {
  sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.clear();
  await auth.signOut();
}
