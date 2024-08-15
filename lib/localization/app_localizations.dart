import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Map<String, String>? _localizedStrings;

  Future<void> load() async {
    try {
      // Load the JSON file
      String jsonString =
          await rootBundle.loadString('lib/l10n/${locale.languageCode}.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      // Map JSON to a Map<String, String>
      _localizedStrings =
          jsonMap.map((key, value) => MapEntry(key, value.toString()));
    } catch (e) {
      // Handle the error, e.g., log it or provide a fallback
      // print('Error loading localization file: $e');
    }
  }

  String translate(String key) {
    return _localizedStrings?[key] ??
        key; // Fallback to key if translation not found
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'th'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
