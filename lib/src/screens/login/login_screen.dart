// EN ESTE LOGIN SCREEN TRATO DE SACAR LA LOGICA DEL DISEÑO EN EL PROVIDER

import 'package:flutter/material.dart';
import 'package:mozoapp/src/localizations/app_localization.dart';
import 'package:mozoapp/src/colors/custom_color_scheme.dart';
import 'package:mozoapp/src/providers/login_provider.dart';
import 'package:mozoapp/src/screens/login/special_button_widget.dart';
import 'package:mozoapp/src/widgets/app_bar_general_widget.dart';
import 'package:mozoapp/src/widgets/custom_input_widget.dart';
import 'package:mozoapp/src/widgets/general_button_widget.dart';
import 'package:mozoapp/src/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  // TODO NO SE COMO CHEQUEAR ACA EN EL INIT YA QUE DA ERROR AL USAR EL PROVIDER
  // QUIZAS HAY UNA MEJOR FORMA DE ENCARAR ESTO.
  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<LoginProvider>(context).checkIfUserIsSignedIn();
  // }

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
      body: Provider.of<LoginProvider>(context).loginWait
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
                            Provider.of<LoginProvider>(context, listen: false).signInWithGoogle().then((result) {
                              if (result) {
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
