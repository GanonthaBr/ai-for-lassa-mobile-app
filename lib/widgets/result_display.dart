import 'package:flutter/material.dart';
import '../models/prediction_result.dart';
import '../utils/constants.dart';
import '../screens/result_screen.dart';

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
      return _buildLoadingState(context);
    }

    if (errorMessage != null) {
      return _buildErrorState(context, errorMessage!);
    }

    if (result == null) {
      return const SizedBox.shrink();
    }

    // Navigate to dedicated result screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ResultScreen(result: result!)),
      );
    });

    return const SizedBox.shrink(); // Return empty widget since navigation will occur
  }

  Widget _buildLoadingState(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppConstants.getResponsiveLargePadding(context)),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(
          AppConstants.getResponsiveButtonRadius(context),
        ),
        border: Border.all(color: AppConstants.primaryColor),
      ),
      child: Column(
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              AppConstants.primaryColor,
            ),
          ),
          SizedBox(height: AppConstants.getResponsivePadding(context)),
          Text(
            'Analyzing symptoms...',
            style: AppConstants.getResponsiveBodyStyle(context).copyWith(
              color: AppConstants.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppConstants.getResponsiveSmallPadding(context)),
          Text(
            'Please wait while we process your data',
            style: AppConstants.getResponsiveCaptionStyle(
              context,
            ).copyWith(color: AppConstants.primaryColor.withOpacity(0.8)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return Container(
      padding: EdgeInsets.all(AppConstants.getResponsiveLargePadding(context)),
      decoration: BoxDecoration(
        color: AppConstants.errorColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(
          AppConstants.getResponsiveButtonRadius(context),
        ),
        border: Border.all(color: AppConstants.errorColor),
      ),
      child: Column(
        children: [
          Icon(Icons.error_outline, color: AppConstants.errorColor, size: 48),
          SizedBox(height: AppConstants.getResponsivePadding(context)),
          Text(
            'Error',
            style: AppConstants.getResponsiveSubtitleStyle(context).copyWith(
              color: AppConstants.errorColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppConstants.getResponsiveSmallPadding(context)),
          Text(
            error,
            style: AppConstants.getResponsiveBodyStyle(
              context,
            ).copyWith(color: AppConstants.errorColor.withOpacity(0.8)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
