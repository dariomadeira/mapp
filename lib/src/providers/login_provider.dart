import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mozoapp/src/preferences/preferences.dart';

class LoginProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool loginWait = true;
  final pref = AppPreferences();
  User currentUser;

  void checkIfUserIsSignedIn() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (pref.logintype == null) {
      this.loginWait = false;
      notifyListeners();
    } else if (pref.logintype == "google") {
      var userSignedIn = await googleSignIn.isSignedIn();
      print("Usuario ya inició sesión con Google: $userSignedIn");
      this.currentUser = _auth.currentUser;
      notifyListeners();
      // TODO NO SE BIEN COMO NAVEGAR ACA
      //Navigator.pushReplacementNamed(context, 'home');
    }
  }

  Future<bool> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      this.currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      print('Inició sesión con Google, usuario: ${user.displayName}');
      pref.logintype = "google";
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    print("Cerró la sesión con Google");
  }
}