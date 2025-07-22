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
  double humidity = AppConstants.defaultHumidity;
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

  void setHumidity(double value) {
    humidity = value;
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
      final symptomData = SymptomData(
        fever: fever ? 1 : 0,
        bleeding: bleeding ? 1 : 0,
        headache: headache ? 1 : 0,
        vomiting: vomiting ? 1 : 0,
        temperature: temperature,
        humidity: humidity,
      );
      final res = await ApiService.submitSymptomData(symptomData);
      isLoading = false;
      result = res;
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
    } on ApiException catch (e) {
      isLoading = false;
      result = null;
      errorMessage = e.message;
      notifyListeners();
      // Dismiss loading screen
      Navigator.of(context, rootNavigator: true).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error: ${e.message}',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: AppConstants.errorColor,
          duration: const Duration(seconds: 5),
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
