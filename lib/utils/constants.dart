import 'package:flutter/material.dart';

class AppConstants {
  // App Information
  static const String appName = 'AI4Lassa - Symptom Reporter';
  static const String appVersion = '1.0.0';

  // API Configuration
  static const String productionIp = 'http://192.168.1.100:5000';
  static const String testingNgrokUrl = 'https://your-ngrok-url.ngrok.io';
  static const bool useNgrokForTesting = true;

  // Environmental Data Ranges
  static const double minHumidity = 0.0;
  static const double maxHumidity = 100.0;
  static const double defaultHumidity = 50.0;

  static const double minTemperature = 20.0;
  static const double maxTemperature = 50.0;
  static const double defaultTemperature = 25.0;

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;

  // Colors
  static const Color primaryColor = Color(0xFF4CAF50);
  static const Color secondaryColor = Color(0xFFFFFFFF);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFF44336);
  static const Color warningColor = Color(0xFFFF9800);
  static const Color highRiskColor = Color(0xFFD32F2F);
  static const Color lowRiskColor = Color(0xFF388E3C);

  // Text Styles
  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black54,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    color: Colors.black87,
  );

  static const TextStyle captionStyle = TextStyle(
    fontSize: 14,
    color: Colors.black54,
  );

  // Button Styles
  static const double buttonHeight = 48.0;
  static const double buttonRadius = 8.0;

  // Slider Styles
  static const double sliderHeight = 40.0;
  static const double sliderTrackHeight = 4.0;
  static const double sliderThumbRadius = 12.0;
}
