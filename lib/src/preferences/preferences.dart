import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  // PATRON SINGLETON
  static final AppPreferences _thisInstance = new AppPreferences._internal();
  factory AppPreferences() {
    return _thisInstance;
  }
  AppPreferences._internal();
  // DECLARAR SHAREDPREFERENCES
  SharedPreferences _prefs;
  // CREAR INSTANCIA
  initPref() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // MOSTRAR SLIDER
  get welcome {
    return _prefs.getBool("welcome") ?? false;
  }

  set welcome(bool value) {
    _prefs.setBool("welcome", value);
  }

  // TIPO DE LOGUEO APLICADO
  get logintype {
    return _prefs.getString("logintype") ?? null;
  }

  set logintype(String value) {
    _prefs.setString("logintype", value);
  }

  // BORRAR TODAS LAS PREFERENCIAS
  set resetAll(bool value) {
    if (value) {
      _prefs.clear();
    }
  }
}
