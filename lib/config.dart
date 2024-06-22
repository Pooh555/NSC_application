import 'dart:convert';

import 'home.dart';

// Necessary information in config files
class Config {
  String theme = "dark"; // Set default theme to dark

  Config(AppTheme currentTheme) {
    theme = currentTheme.theme;
  }

  String createJson() {
    Map<String, String> configData = {
      'theme': theme,
    };

    return json.encode(configData);
  }
}
