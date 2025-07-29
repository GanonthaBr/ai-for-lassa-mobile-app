import 'package:flutter/material.dart';
import '../models/symptom_data.dart';
import '../models/prediction_result.dart';
import 'api_service.dart';
import '../utils/constants.dart';
import '../widgets/loading_screen.dart';

class SymptomAnalysisProvider extends ChangeNotifier {
  // Form data
  bool fever = false;
  bool bleeding = false;
  bool headache = false;
  bool vomiting = false;
  double temperature = AppConstants.defaultTemperature;

  // UI state
  bool isLoading = false;
  PredictionResult? result;
  String? errorMessage;

  void setFever(bool value) {
    fever = value;
    notifyListeners();
  }

  void setBleeding(bool value) {
    bleeding = value;
    notifyListeners();
  }

  void setTemperature(double value) {
    temperature = value;
    notifyListeners();
  }

  void setHeadache(bool value) {
    headache = value;
    notifyListeners();
  }

  void setVomiting(bool value) {
    vomiting = value;
    notifyListeners();
  }

  void setMockResult() {
    result = PredictionResult(prediction: 1, risk: 'High');
    errorMessage = null;
    isLoading = false;
    notifyListeners();
  }

  Future<void> submitData(BuildContext context) async {
    isLoading = true;
    result = null;
    errorMessage = null;
    notifyListeners();

    // Show loading screen
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LoadingScreen(),
    );

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));
      // Set mock result
      result = PredictionResult(prediction: 35, risk: 'High');
      isLoading = false;
      errorMessage = null;
      notifyListeners();
      // Dismiss loading screen
      Navigator.of(context, rootNavigator: true).pop();
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Analysis completed successfully! (Mock)',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppConstants.successColor,
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      isLoading = false;
      result = null;
      errorMessage = 'Unexpected error: $e';
      notifyListeners();
      // Dismiss loading screen
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
