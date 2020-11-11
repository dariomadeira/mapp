import 'package:flutter/material.dart';
import 'package:mozoapp/src/localizations/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mozoapp/src/preferences/preferences.dart';
import 'package:mozoapp/src/providers/login_provider.dart';
//import 'package:mozoapp/src/providers/user_provider.dart';
import 'package:mozoapp/src/routes/routes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final pref = new AppPreferences();
  await pref.initPref();
  await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoder, 'assets/svgs/logo.svg'), null);
  runApp(
    MultiProvider(
      providers: [
        // TODO solo para usar con el login FUNCIONA
        // ChangeNotifierProvider(
        //   create: (_) => new UserProvider(),
        // ),
        ChangeNotifierProvider(
          create: (_) => new LoginProvider(),
        ),
      ],
      child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  final pref = new AppPreferences();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment=false;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      supportedLocales: [
        Locale('es', ''),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      title: 'Mozo App',
      debugShowCheckedModeBanner: false,
      initialRoute: (pref.welcome) ? 'login' : 'slider',
      routes: appRoutes,
      theme: ThemeData(
        fontFamily: 'Comfortaa',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
        ),
      ),
    );
  }
}
