// CON ESTE LOGIN SCREEN MESCLADO CON LA LOGICA,
// FUNCIONA EL LOGUEO EN GOOGLE

import 'package:flutter/material.dart';
import 'package:mozoapp/src/localizations/app_localization.dart';
import 'package:mozoapp/src/colors/custom_color_scheme.dart';
import 'package:mozoapp/src/preferences/preferences.dart';
import 'package:mozoapp/src/providers/user_provider.dart';
import 'package:mozoapp/src/screens/login/special_button_widget.dart';
import 'package:mozoapp/src/widgets/app_bar_general_widget.dart';
import 'package:mozoapp/src/widgets/custom_input_widget.dart';
import 'package:mozoapp/src/widgets/general_button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mozoapp/src/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool _loginWait = true;
  final pref = AppPreferences();

  @override
  void initState() {
    super.initState();
    checkIfUserIsSignedIn();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void checkIfUserIsSignedIn() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (pref.logintype == null) {
      setState(() {
        _loginWait = false;
      });
    } else if (pref.logintype == "google") {
      var userSignedIn = await googleSignIn.isSignedIn();
      print("Usuario ya inició sesión con Google: $userSignedIn");
      final User user = _auth.currentUser;
      Provider.of<UserProvider>(context, listen: false).setUserName = user.displayName;
      Provider.of<UserProvider>(context, listen: false).setUserImagePath = user.photoURL;
      Navigator.pushReplacementNamed(context, 'home');
    }
  }

  Future<String> signInWithGoogle() async {
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
      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      print('Inició sesión con Google, usuario: ${user.displayName}');
      Provider.of<UserProvider>(context, listen: false).setUserName = user.displayName;
      Provider.of<UserProvider>(context, listen: false).setUserImagePath = user.photoURL;
      pref.logintype = "google";
      return '$user';
    }
    return null;
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    print("Cerró la sesión con Google");
  }

  void _showToastErrorSingIn(scaffoldKey) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(AppLocalizations.of(context).translate("login.error")),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBarGeneral(),
      body: _loginWait
      ? LoadingWidget(loadingMessage: "general.singin")
      : NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
            return;
          },
          child: SingleChildScrollView(
            child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/images/detail1.png"),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context).translate("login.title"),
                        style: TextStyle(
                          fontSize: 24,
                          color: Theme.of(context).colorScheme.grayDark,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        AppLocalizations.of(context).translate("login.subtitle"),
                        style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.grayNormal, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 30),
                      CustomInput(
                        icon: Icons.alternate_email,
                        placeholder: AppLocalizations.of(context).translate("login.email.hint"),
                        keyboardType: TextInputType.emailAddress,
                        textController: emailCtrl,
                      ),
                      const SizedBox(height: 20),
                      CustomInput(
                        icon: Icons.lock_outline,
                        placeholder: AppLocalizations.of(context).translate("login.password.hint"),
                        textController: passCtrl,
                        isPassword: true,
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          AppLocalizations.of(context).translate("login.password.lose"),
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.grayNormal,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: GeneralButtonWidget(
                          btnText: AppLocalizations.of(context).translate("login.login"),
                          buttonAction: () => {},
                          styleBtn: 0,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context).translate("login.notaccount"),
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.grayNormal,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            height: 40,
                            child: GeneralButtonWidget(
                              btnText: AppLocalizations.of(context).translate("login.account.create"),
                              buttonAction: () => {},
                              styleBtn: 0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          AppLocalizations.of(context).translate("login.loginwith"),
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.grayNormal,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: SpecialButtonWidget(
                          btnText: AppLocalizations.of(context).translate("login.loginwith.facebook"),
                          buttonAction: () => {},
                          styleBtn: 0,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: SpecialButtonWidget(
                          btnText: AppLocalizations.of(context).translate("login.loginwith.google"),
                          buttonAction: () => {
                            signInWithGoogle().then((result) {
                              if (result != null) {
                                Navigator.pushReplacementNamed(context, 'home');
                              } else {
                                _showToastErrorSingIn(_scaffoldKey);
                              }
                            })
                          },
                          styleBtn: 1,
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          )
        ),
      )
    );
  }
}
