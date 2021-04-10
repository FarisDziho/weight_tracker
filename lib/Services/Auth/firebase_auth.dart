import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _auth;

  AuthenticationService(this._auth);
  Stream<User> get authStateChanges => _auth.authStateChanges();

  Future signInAnonymusli() async {
    await _auth.signInAnonymously();
  }

  FirebaseAuth getfirebaseAuth() => _auth;

  Future signOut() async {
    try {
      print("sign out");
      await _auth.signOut();
    } catch (err) {
      print(err);
    }
  }
}
