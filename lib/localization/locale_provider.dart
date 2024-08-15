import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('th');

  Locale get locale => _locale;

  LocaleProvider(Locale locale) {
    init();
  }

  void setLocale(Locale locale) {
    if (locale == _locale) return;
    _locale = locale;
    saveLocale(locale);
    notifyListeners();
  }

  Future<void> init() async {
    try {
      _locale = await getLocale();
      notifyListeners();
    } catch (e) {
      // Handle any errors that might occur during initialization
      // print('Failed to load locale: $e');
    }
  }

  Future<void> saveLocale(Locale locale) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('language', locale.languageCode);
    } catch (e) {
      // Handle any errors that might occur while saving
      // print('Failed to save locale: $e');
    }
  }

  Future<Locale> getLocale() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String languageCode = prefs.getString('language') ?? 'en';
      return Locale(languageCode);
    } catch (e) {
      // Handle any errors that might occur while retrieving
      // print('Failed to get locale: $e');
      return const Locale('en');
    }
  }
}
