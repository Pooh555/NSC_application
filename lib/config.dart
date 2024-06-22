import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class Config {
  static const String _fileName = 'config.json';
  static const String _defaultTheme = 'dark';

  late String theme;

  Config({this.theme = _defaultTheme});

  // Convert a Config object into a Map object
  Map<String, dynamic> toJson() => {
        'theme': theme,
      };

  // Load config from JSON file
  static Future<Config> load() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_fileName');

      if (await file.exists()) {
        final contents = await file.readAsString();
        final jsonMap = json.decode(contents);
        return Config(
          theme: jsonMap['theme'] ?? _defaultTheme,
        );
      } else {
        // If the file doesn't exist, create it with default values
        final config = Config();
        await config.save();
        return config;
      }
    } catch (e) {
      // If there's an error, return a config with default values
      return Config();
    }
  }

  // Save config to JSON file
  Future<void> save() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$_fileName');
    final contents = json.encode(toJson());
    await file.writeAsString(contents);
  }

  // Load the default config from assets
  static Future<Config> loadFromAssets() async {
    try {
      final contents = await rootBundle.loadString('assets/config.json');
      final jsonMap = json.decode(contents);
      return Config(
        theme: jsonMap['theme'] ?? _defaultTheme,
      );
    } catch (e) {
      return Config();
    }
  }
}
