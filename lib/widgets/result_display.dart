import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../models/prediction_result.dart';
import '../utils/constants.dart';

class ResultDisplay extends StatefulWidget {
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
  State<ResultDisplay> createState() => _ResultDisplayState();
}

class _ResultDisplayState extends State<ResultDisplay>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    if (widget.result != null) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(ResultDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.result != null && oldWidget.result == null) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return _buildLoadingState();
    }

    if (widget.errorMessage != null) {
      return _buildErrorState(widget.errorMessage!);
    }

    if (widget.result == null) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: _buildResultState(widget.result!),
          ),
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[50]!, Colors.blue[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
        border: Border.all(color: AppConstants.primaryColor),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppConstants.primaryColor,
                  ),
                  strokeWidth: 3,
                ),
              ),
              Icon(
                Icons.psychology,
                color: AppConstants.primaryColor,
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Text(
            'AI Analysis in Progress',
            style: AppConstants.bodyStyle.copyWith(
              color: AppConstants.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: AppConstants.smallPadding),
          Text(
            'Processing your symptoms and environmental data...',
            style: AppConstants.captionStyle.copyWith(
              color: AppConstants.primaryColor.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding,
              vertical: AppConstants.smallPadding,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppConstants.primaryColor.withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.security,
                  color: AppConstants.primaryColor,
                  size: 16,
                ),
                const SizedBox(width: AppConstants.smallPadding),
                Text(
                  'Secure & Confidential',
                  style: AppConstants.captionStyle.copyWith(
                    color: AppConstants.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
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
        border: Border.all(color: AppConstants.errorColor, width: 2),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppConstants.errorColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.error_outline,
              color: AppConstants.errorColor,
              size: 48,
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Text(
            'Analysis Failed',
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
          const SizedBox(height: AppConstants.defaultPadding),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Retry logic would be implemented here
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please try submitting your data again'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppConstants.errorColor,
                    side: BorderSide(color: AppConstants.errorColor),
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.defaultPadding),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Contact support logic
                  },
                  icon: const Icon(Icons.support_agent),
                  label: const Text('Support'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppConstants.errorColor,
                    side: BorderSide(color: AppConstants.errorColor),
                  ),
                ),
              ),
            ],
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
              Icon(riskIcon, color: riskColor, size: 40),
              const SizedBox(width: AppConstants.smallPadding),
              Text(
                riskTitle,
                style: AppConstants.titleStyle.copyWith(
                  color: riskColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppConstants.defaultPadding),

          // Show prediction as percentage
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding,
              vertical: AppConstants.smallPadding,
            ),
            decoration: BoxDecoration(
              color: riskColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'You have a ${result.prediction}% chance of having Lassa fever',
              style: AppConstants.bodyStyle.copyWith(
                color: riskColor,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
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
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: AppConstants.smallPadding),
                Text(
                  isHighRisk
                      ? 'Seek immediate medical attention. Contact healthcare provider.'
                      : 'Monitor symptoms. Continue with normal activities.',
                  style: AppConstants.bodyStyle.copyWith(
                    color: Colors.black87,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem({
    required IconData icon,
    required String text,
    required bool priority,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: priority ? color.withOpacity(0.1) : Colors.grey[100],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              icon,
              size: 16,
              color: priority ? color : Colors.grey[600],
            ),
          ),
          const SizedBox(width: AppConstants.smallPadding),
          Expanded(
            child: Text(
              text,
              style: AppConstants.bodyStyle.copyWith(
                fontWeight: priority ? FontWeight.w600 : FontWeight.normal,
                color: priority ? color : Colors.black87,
              ),
            ),
          ),
          if (priority)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'URGENT',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _shareResults(PredictionResult result) {
    final text =
        '''
AI4Lassa Assessment Results
Risk Level: ${result.risk}
Prediction: ${result.prediction}
Date: ${DateTime.now().toString().substring(0, 19)}

This is a preliminary screening result. Please consult healthcare professionals for proper medical evaluation.
''';
    Share.share(text, subject: 'AI4Lassa Assessment Results');
  }

  void _saveResults(PredictionResult result) {
    // Implementation for saving results locally
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Results saved successfully'),
        backgroundColor: AppConstants.successColor,
        action: SnackBarAction(
          label: 'View',
          textColor: Colors.white,
          onPressed: () {
            // Navigate to saved results screen
          },
        ),
      ),
    );
  }
}
