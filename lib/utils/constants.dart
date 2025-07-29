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

  // Temperature Ranges (for body temperature in symptoms)
  static const double minTemperature = 35.0;
  static const double maxTemperature = 42.0;
  static const double defaultTemperature = 37.0;
  static const double feverThreshold = 37.5;
  static const double criticalTempThreshold = 40.0;

  // Responsive UI Constants
  static double getResponsivePadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) return 16.0; // Mobile
    if (screenWidth < 900) return 24.0; // Tablet
    return 32.0; // Desktop
  }

  static double getResponsiveSmallPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) return 8.0;
    if (screenWidth < 900) return 12.0;
    return 16.0;
  }

  static double getResponsiveLargePadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) return 24.0;
    if (screenWidth < 900) return 32.0;
    return 48.0;
  }

  static double getResponsiveButtonHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight < 600) return 48.0;
    if (screenHeight < 800) return 56.0;
    return 64.0;
  }

  static double getResponsiveButtonRadius(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) return 8.0;
    if (screenWidth < 900) return 12.0;
    return 16.0;
  }

  static double getResponsiveSliderHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight < 600) return 40.0;
    if (screenHeight < 800) return 48.0;
    return 56.0;
  }

  static double getResponsiveSliderTrackHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight < 600) return 4.0;
    if (screenHeight < 800) return 6.0;
    return 8.0;
  }

  static double getResponsiveSliderThumbRadius(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) return 12.0;
    if (screenWidth < 900) return 16.0;
    return 20.0;
  }

  // Responsive Text Styles
  static TextStyle getResponsiveTitleStyle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double fontSize = 28.0;
    if (screenWidth < 600) fontSize = 24.0;
    if (screenWidth < 900) fontSize = 28.0;
    if (screenWidth >= 900) fontSize = 32.0;

    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    );
  }

  static TextStyle getResponsiveSubtitleStyle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double fontSize = 22.0;
    if (screenWidth < 600) fontSize = 18.0;
    if (screenWidth < 900) fontSize = 22.0;
    if (screenWidth >= 900) fontSize = 26.0;

    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: Colors.black54,
    );
  }

  static TextStyle getResponsiveBodyStyle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double fontSize = 18.0;
    if (screenWidth < 600) fontSize = 16.0;
    if (screenWidth < 900) fontSize = 18.0;
    if (screenWidth >= 900) fontSize = 20.0;

    return TextStyle(fontSize: fontSize, color: Colors.black87);
  }

  static TextStyle getResponsiveCaptionStyle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double fontSize = 16.0;
    if (screenWidth < 600) fontSize = 14.0;
    if (screenWidth < 900) fontSize = 16.0;
    if (screenWidth >= 900) fontSize = 18.0;

    return TextStyle(fontSize: fontSize, color: Colors.black54);
  }

  // Legacy static constants for backward compatibility
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double buttonHeight = 48.0;
  static const double buttonRadius = 8.0;
  static const double sliderHeight = 40.0;
  static const double sliderTrackHeight = 4.0;
  static const double sliderThumbRadius = 12.0;

  // Legacy text styles for backward compatibility
  static const TextStyle titleStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: Colors.black54,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 18,
    color: Colors.black87,
  );

  static const TextStyle bodyBoldStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static const TextStyle captionStyle = TextStyle(
    fontSize: 16,
    color: Colors.black54,
  );

  // Colors
  static const Color primaryColor = Color(0xFF4CAF50);
  static const Color secondaryColor = Color(0xFFFFFFFF);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFF44336);
  static const Color warningColor = Color(0xFFFF9800);
  static const Color highRiskColor = Color(0xFFD32F2F);
  static const Color lowRiskColor = Color(0xFF388E3C);
  static const Color moderateRiskColor = Color(0xFFFF9800);
  static const Color criticalRiskColor = Color(0xFFD32F2F);
  static const Color mildSymptomColor = Color(0xFF4CAF50);
  static const Color moderateSymptomColor = Color(0xFFFF9800);
  static const Color severeSymptomColor = Color(0xFFF44336);
  static const Color criticalSymptomColor = Color(0xFFD32F2F);

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 800);

  // Border Radius
  static const double cardRadius = 12.0;
  static const double containerRadius = 8.0;

  // Validation Methods
  static bool isValidTemperature(double temperature) {
    return temperature >= minTemperature && temperature <= maxTemperature;
  }

  static bool isFeverTemperature(double temperature) {
    return temperature >= feverThreshold;
  }

  static bool isCriticalTemperature(double temperature) {
    return temperature >= criticalTempThreshold;
  }

  static String getTemperatureStatus(double temperature) {
    if (temperature >= criticalTempThreshold) return 'Critical';
    if (temperature >= feverThreshold) return 'Fever';
    if (temperature < 35.0) return 'Low';
    return 'Normal';
  }
}
