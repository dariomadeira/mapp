import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  // constructor
  final Locale locale;
  AppLocalizations(
    this.locale
  );
  // Método auxiliar para mantener el código en los widgets concisos
  // Se accede a las localizaciones utilizando una sintaxis InheritedWidget "of"
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
  // Miembro estático para tener un acceso simple al delegate desde la MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
  Map<String, String> _localizedStrings;
  Future<bool> load() async {
    // Cargar el archivo JSON de idioma de la carpeta "i18n"
    String jsonString = await rootBundle.loadString('i18n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }
  // Se llamará a este método desde cada widget que necesite un texto localizado
  String translate(String key) {
    return _localizedStrings[key];
  }
}

// delegate
class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  // Esta instancia de delegate nunca cambiará (¡ni siquiera tiene campos!)
  // Puede proporcionar un constructor constante.
  const _AppLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    // Incluya todos sus códigos de idiomas compatibles aquí
    return ['es'].contains(locale.languageCode);
  }
  @override
  Future<AppLocalizations> load(Locale locale) async {
    // La clase AppLocalizations es donde realmente se ejecuta la carga JSON
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }
  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}