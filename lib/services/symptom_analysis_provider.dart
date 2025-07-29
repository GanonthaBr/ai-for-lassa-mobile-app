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

  Future<void> submitData(
    BuildContext context, {
    required bool fever,
    required bool bleeding,
    required bool headache,
    required bool vomiting,
    required double temperature,
  }) async {
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
      // Create symptom data for API using the provided parameters
      //before sending the request we should ensure each data is int except from the temperature

      final symptomData = SymptomData(
        fever: fever ? 1 : 0,
        bleeding: bleeding ? 1 : 0,
        headache: headache ? 1 : 0,
        vomiting: vomiting ? 1 : 0,
        temperature: temperature,
      );

      // Call the real API
      final predictionResult = await ApiService.submitSymptomData(symptomData);
      print('Result: $predictionResult');

      result = predictionResult;
      isLoading = false;
      errorMessage = null;
      notifyListeners();

      // Dismiss loading screen
      Navigator.of(context, rootNavigator: true).pop();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Analysis completed successfully!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppConstants.successColor,
          duration: const Duration(seconds: 3),
        ),
      );

      // Clear result after a delay to prevent repeated navigation
      Future.delayed(const Duration(seconds: 1), () {
        result = null;
        notifyListeners();
      });
    } on ApiException catch (e) {
      isLoading = false;
      result = null;
      errorMessage = 'Unable to complete assessment. Please try again.';
      notifyListeners();
      // Dismiss loading screen
      Navigator.of(context, rootNavigator: true).pop();

      // Show generic error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Unable to complete assessment. Please check your connection and try again.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppConstants.errorColor,
          duration: const Duration(seconds: 5),
        ),
      );
    } catch (e) {
      isLoading = false;
      result = null;
      errorMessage = 'Something went wrong. Please try again.';
      notifyListeners();
      // Dismiss loading screen
      Navigator.of(context, rootNavigator: true).pop();

      // Show generic error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Something went wrong. Please try again later.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppConstants.errorColor,
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }
}
