import 'package:mozoapp/src/screens/home/home_screen.dart';
import 'package:mozoapp/src/screens/login/login_screen.dart';
import 'package:mozoapp/src/screens/slider/slider_screen.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'slider': (_) => SliderScreen(),
  'home': (_) => HomeScreen(),
  'login': (_) => LoginScreen(),
};
