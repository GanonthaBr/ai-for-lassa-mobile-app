import 'package:flutter/material.dart';

class AppConstants {
  // App Information
  static const String appName = 'AI4Lassa - Symptom Reporter';
  static const String appVersion = '1.2.0';
  static const String appDescription =
      'AI-powered Lassa fever detection and risk assessment';

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

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double extraLargePadding = 32.0;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 300);
  static const Duration mediumAnimation = Duration(milliseconds: 600);
  static const Duration longAnimation = Duration(milliseconds: 1000);

  // Colors - Enhanced Palette
  static const Color primaryColor = Color(
    0xFF2E7D32,
  ); // Darker green for medical trust
  static const Color secondaryColor = Color(0xFF81C784); // Light green
  static const Color accentColor = Color(0xFF4CAF50); // Original green

  // Status Colors
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color warningColor = Color(0xFFFF8F00);
  static const Color infoColor = Color(0xFF1976D2);

  // Risk Assessment Colors
  static const Color lowRiskColor = Color(0xFF2E7D32);
  static const Color moderateRiskColor = Color(0xFFFF8F00);
  static const Color highRiskColor = Color(0xFFD32F2F);
  static const Color criticalRiskColor = Color(0xFFB71C1C);

  // Symptom Severity Colors
  static const Color mildSymptomColor = Color(0xFF81C784);
  static const Color moderateSymptomColor = Color(0xFFFFB74D);
  static const Color severeSymptomColor = Color(0xFFE57373);
  static const Color criticalSymptomColor = Color(0xFFE53935);

  // Background Colors
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color cardColor = Color(0xFFFAFAFA);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textDisabled = Color(0xFFBDBDBD);

  // Text Styles - Enhanced Typography
  static const TextStyle displayStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textPrimary,
    letterSpacing: -0.5,
  );

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

  static const TextStyle headlineStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: textPrimary,
    letterSpacing: 0,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 18,
    color: Colors.black87,
  );

  static const TextStyle bodyBoldStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    letterSpacing: 0.15,
  );

  static const TextStyle captionStyle = TextStyle(
    fontSize: 16,
    color: Colors.black54,
  );

  static const TextStyle labelStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: textSecondary,
    letterSpacing: 0.5,
  );

  // Button Styles
  static const double buttonHeight = 48.0;
  static const double buttonRadius = 12.0;
  static const double smallButtonHeight = 36.0;
  static const double largeButtonHeight = 56.0;

  // Card & Container Styles
  static const double cardElevation = 2.0;
  static const double cardRadius = 12.0;
  static const double containerRadius = 8.0;

  // Slider Styles
  static const double sliderHeight = 40.0;
  static const double sliderTrackHeight = 6.0;
  static const double sliderThumbRadius = 14.0;

  // Icon Sizes
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconExtraLarge = 48.0;

  // Spacing Constants
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // Medical Constants
  static const List<String> criticalSymptoms = [
    'bleeding',
    'difficulty_breathing',
    'severe_headache',
    'high_fever',
  ];

  static const Map<String, String> symptomDescriptions = {
    'fever': 'Body temperature above 37.5°C (99.5°F)',
    'bleeding': 'Unusual bleeding from nose, gums, or other areas',
    'headache': 'Persistent or severe headache',
    'vomiting': 'Nausea, vomiting, or stomach upset',
  };

  static const Map<String, String> symptomDetails = {
    'fever':
        'High fever is a key early symptom of Lassa fever and may persist for days',
    'bleeding':
        'May include nosebleeds, gum bleeding, bruising, or internal bleeding',
    'headache':
        'Often described as intense, throbbing, and different from normal headaches',
    'vomiting': 'May be accompanied by loss of appetite and abdominal pain',
  };

  // Risk Assessment Messages
  static const Map<String, Map<String, String>> riskMessages = {
    'low': {
      'title': 'Low Risk Assessment',
      'message':
          'Based on your symptoms and environmental data, the risk appears low.',
      'action':
          'Continue monitoring your health and maintain normal activities.',
    },
    'moderate': {
      'title': 'Moderate Risk Assessment',
      'message':
          'Some concerning symptoms detected. Medical evaluation recommended.',
      'action':
          'Consider consulting a healthcare provider for proper evaluation.',
    },
    'high': {
      'title': 'High Risk Assessment',
      'message':
          'Multiple risk factors detected. Immediate medical attention recommended.',
      'action': 'Seek immediate medical care and contact healthcare providers.',
    },
    'critical': {
      'title': 'Critical Risk Assessment',
      'message':
          'Severe symptoms detected requiring urgent medical intervention.',
      'action': 'Seek emergency medical care immediately. Do not delay.',
    },
  };

  // Validation Constants
  static const int maxSymptomDuration = 30; // days
  static const int minAge = 0;
  static const int maxAge = 120;

  // Network Constants
  static const Duration networkTimeout = Duration(seconds: 30);
  static const Duration shortTimeout = Duration(seconds: 10);
  static const int maxRetryAttempts = 3;

  // Storage Keys
  static const String userPreferencesKey = 'user_preferences';
  static const String lastAssessmentKey = 'last_assessment';
  static const String assessmentHistoryKey = 'assessment_history';
  static const String settingsKey = 'app_settings';

  // Feature Flags
  static const bool enableAdvancedAnalytics = true;
  static const bool enableOfflineMode = false;
  static const bool enableLocationTracking = false;
  static const bool enableNotifications = true;

  // URLs and Links
  static const String privacyPolicyUrl = 'https://ai4lassa.org/privacy';
  static const String termsOfServiceUrl = 'https://ai4lassa.org/terms';
  static const String supportEmail = 'support@ai4lassa.org';
  static const String emergencyHotline = '+234-XXX-XXXX-XXX';

  // Educational Resources
  static const Map<String, String> educationalLinks = {
    'WHO Lassa Fever':
        'https://www.who.int/news-room/fact-sheets/detail/lassa-fever',
    'CDC Information': 'https://www.cdc.gov/vhf/lassa/',
    'ISARIC Resources': 'https://isaric.org/research/lassa-fever-resources/',
    'Local Health Ministry': 'https://health.gov.ng/lassa-fever',
  };

  // Theme Configuration
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: MaterialColor(primaryColor.value, <int, Color>{
        50: primaryColor.withOpacity(0.1),
        100: primaryColor.withOpacity(0.2),
        200: primaryColor.withOpacity(0.3),
        300: primaryColor.withOpacity(0.4),
        400: primaryColor.withOpacity(0.5),
        500: primaryColor,
        600: primaryColor.withOpacity(0.7),
        700: primaryColor.withOpacity(0.8),
        800: primaryColor.withOpacity(0.9),
        900: primaryColor,
      }),
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      cardColor: cardColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          minimumSize: const Size(double.infinity, buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
          side: const BorderSide(color: primaryColor),
        ),
      ),
      // cardTheme: CardTheme(
      //   elevation: cardElevation,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(cardRadius),
      //   ),
      // ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(containerRadius)),
        ),
        contentPadding: const EdgeInsets.all(defaultPadding),
      ),
    );
  }

  // Helper Methods
  static Color getRiskColor(String risk) {
    switch (risk.toLowerCase()) {
      case 'low':
        return lowRiskColor;
      case 'moderate':
        return moderateRiskColor;
      case 'high':
        return highRiskColor;
      case 'critical':
        return criticalRiskColor;
      default:
        return primaryColor;
    }
  }

  static IconData getRiskIcon(String risk) {
    switch (risk.toLowerCase()) {
      case 'low':
        return Icons.check_circle;
      case 'moderate':
        return Icons.warning;
      case 'high':
        return Icons.error;
      case 'critical':
        return Icons.dangerous;
      default:
        return Icons.help;
    }
  }

  static Color getSymptomSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'mild':
        return mildSymptomColor;
      case 'moderate':
        return moderateSymptomColor;
      case 'severe':
        return severeSymptomColor;
      case 'critical':
        return criticalSymptomColor;
      default:
        return primaryColor;
    }
  }

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
