import 'package:flutter/material.dart';
import '../models/prediction_result.dart';
import '../utils/constants.dart';

class ResultDisplay extends StatelessWidget {
  final PredictionResult? result;
  final bool isLoading;
  final String? errorMessage;

  const ResultDisplay({
    super.key,
    this.result,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingState();
    }

    if (errorMessage != null) {
      return _buildErrorState(errorMessage!);
    }

    if (result == null) {
      return const SizedBox.shrink();
    }

    return _buildResultState(result!);
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
        border: Border.all(color: AppConstants.primaryColor),
      ),
      child: Column(
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              AppConstants.primaryColor,
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Text(
            'Analyzing symptoms...',
            style: AppConstants.bodyStyle.copyWith(
              color: AppConstants.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppConstants.smallPadding),
          Text(
            'Please wait while we process your data',
            style: AppConstants.captionStyle.copyWith(
              color: AppConstants.primaryColor.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      decoration: BoxDecoration(
        color: AppConstants.errorColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
        border: Border.all(color: AppConstants.errorColor),
      ),
      child: Column(
        children: [
          Icon(Icons.error_outline, color: AppConstants.errorColor, size: 48),
          const SizedBox(height: AppConstants.defaultPadding),
          Text(
            'Error',
            style: AppConstants.subtitleStyle.copyWith(
              color: AppConstants.errorColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.smallPadding),
          Text(
            error,
            style: AppConstants.bodyStyle.copyWith(
              color: AppConstants.errorColor.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildResultState(PredictionResult result) {
    final isHighRisk = result.risk.toLowerCase() == 'high';
    final riskColor = isHighRisk
        ? AppConstants.highRiskColor
        : AppConstants.lowRiskColor;
    final riskIcon = isHighRisk ? Icons.warning : Icons.check_circle;
    final riskTitle = isHighRisk ? 'High Risk' : 'Low Risk';

    return Container(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      decoration: BoxDecoration(
        color: riskColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
        border: Border.all(color: riskColor, width: 2),
      ),
      child: Column(
        children: [
          // Risk Level Icon and Title
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(riskIcon, color: riskColor, size: 32),
              const SizedBox(width: AppConstants.smallPadding),
              Text(
                riskTitle,
                style: AppConstants.titleStyle.copyWith(
                  color: riskColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppConstants.defaultPadding),

          // Show prediction value
          Text(
            'Prediction: ${result.prediction}',
            style: AppConstants.bodyStyle.copyWith(
              color: riskColor,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: AppConstants.defaultPadding),

          // Recommendation
          Container(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
              border: Border.all(color: riskColor.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Text(
                  'Recommendation',
                  style: AppConstants.bodyStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: riskColor,
                  ),
                ),
                const SizedBox(height: AppConstants.smallPadding),
                Text(
                  isHighRisk
                      ? 'Seek immediate medical attention. Contact healthcare provider.'
                      : 'Monitor symptoms. Continue with normal activities.',
                  style: AppConstants.bodyStyle.copyWith(color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
