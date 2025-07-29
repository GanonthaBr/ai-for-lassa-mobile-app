import 'package:flutter/material.dart';
import '../models/prediction_result.dart';
import '../utils/constants.dart';

class ResultScreen extends StatelessWidget {
  final PredictionResult result;

  const ResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final isHighRisk = result.risk.toLowerCase() == 'high';
    final isMediumRisk = result.risk.toLowerCase() == 'medium';

    Color riskColor;
    IconData riskIcon;
    String riskTitle;

    if (isHighRisk) {
      riskColor = AppConstants.highRiskColor;
      riskIcon = Icons.warning;
      riskTitle = 'High Risk';
    } else if (isMediumRisk) {
      riskColor = AppConstants.warningColor;
      riskIcon = Icons.info;
      riskTitle = 'Medium Risk';
    } else {
      riskColor = AppConstants.lowRiskColor;
      riskIcon = Icons.check_circle;
      riskTitle = 'Low Risk';
    }

    return Scaffold(
      backgroundColor: Colors.grey[50], // More visible background
      appBar: AppBar(
        title: Text(
          'Assessment Result',
          style: AppConstants.getResponsiveTitleStyle(
            context,
          ).copyWith(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: riskColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Share feature coming soon')),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [riskColor.withOpacity(0.1), Colors.grey[50]!],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppConstants.getResponsivePadding(context)),
          child: Column(
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(
                  AppConstants.getResponsiveLargePadding(context),
                ),
                decoration: BoxDecoration(
                  color: riskColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    AppConstants.getResponsiveButtonRadius(context),
                  ),
                  border: Border.all(color: riskColor, width: 2),
                ),
                child: Column(
                  children: [
                    // Risk Level Icon
                    Container(
                      padding: EdgeInsets.all(
                        AppConstants.getResponsivePadding(context),
                      ),
                      decoration: BoxDecoration(
                        color: riskColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(riskIcon, color: Colors.white, size: 48),
                    ),
                    SizedBox(
                      height: AppConstants.getResponsivePadding(context),
                    ),
                    Text(
                      riskTitle,
                      style: AppConstants.getResponsiveTitleStyle(
                        context,
                      ).copyWith(color: riskColor, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: AppConstants.getResponsiveSmallPadding(context),
                    ),
                    Text(
                      'Assessment Complete',
                      style: AppConstants.getResponsiveCaptionStyle(
                        context,
                      ).copyWith(color: riskColor.withOpacity(0.8)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppConstants.getResponsiveLargePadding(context)),

              // Prediction Percentage Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(
                  AppConstants.getResponsiveLargePadding(context),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    AppConstants.getResponsiveButtonRadius(context),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      '${result.prediction}%',
                      style: AppConstants.getResponsiveTitleStyle(context)
                          .copyWith(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: riskColor,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: AppConstants.getResponsiveSmallPadding(context),
                    ),
                    Text(
                      'chance of having Lassa fever',
                      style: AppConstants.getResponsiveBodyStyle(context)
                          .copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppConstants.getResponsiveLargePadding(context)),

              // Recommendation Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(
                  AppConstants.getResponsivePadding(context),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    AppConstants.getResponsiveButtonRadius(context),
                  ),
                  border: Border.all(color: riskColor.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          isHighRisk ? Icons.emergency : Icons.check_circle,
                          color: riskColor,
                          size: 24,
                        ),
                        SizedBox(
                          width: AppConstants.getResponsiveSmallPadding(
                            context,
                          ),
                        ),
                        Text(
                          'Recommendation',
                          style:
                              AppConstants.getResponsiveSubtitleStyle(
                                context,
                              ).copyWith(
                                fontWeight: FontWeight.bold,
                                color: riskColor,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppConstants.getResponsivePadding(context),
                    ),
                    Text(
                      isHighRisk
                          ? 'Seek immediate medical attention. Contact healthcare provider as soon as possible. Do not delay treatment.'
                          : isMediumRisk
                          ? 'Monitor your symptoms closely and consider consulting a healthcare provider if symptoms persist or worsen.'
                          : 'Continue monitoring your symptoms. Maintain normal activities but stay alert to any changes.',
                      style: AppConstants.getResponsiveBodyStyle(
                        context,
                      ).copyWith(color: Colors.black87, height: 1.4),
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppConstants.getResponsiveLargePadding(context)),

              // Additional Information Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(
                  AppConstants.getResponsivePadding(context),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(
                    AppConstants.getResponsiveButtonRadius(context),
                  ),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.blue[700],
                          size: 20,
                        ),
                        SizedBox(
                          width: AppConstants.getResponsiveSmallPadding(
                            context,
                          ),
                        ),
                        Text(
                          'Important Information',
                          style:
                              AppConstants.getResponsiveSubtitleStyle(
                                context,
                              ).copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[700],
                              ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppConstants.getResponsivePadding(context),
                    ),
                    Text(
                      'This is a preliminary screening result. Always consult healthcare professionals for proper medical evaluation and diagnosis.',
                      style: AppConstants.getResponsiveBodyStyle(
                        context,
                      ).copyWith(color: Colors.blue[700], height: 1.4),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: AppConstants.getResponsiveLargePadding(context) * 2,
              ),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: Text(
                        'Back to Home',
                        style: AppConstants.getResponsiveBodyStyle(
                          context,
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: riskColor,
                        side: BorderSide(color: riskColor),
                        padding: EdgeInsets.symmetric(
                          vertical: AppConstants.getResponsivePadding(context),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: AppConstants.getResponsivePadding(context)),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Action based on risk level
                        if (isHighRisk) {
                          // Show emergency contacts or call functionality
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Emergency contacts feature coming soon',
                              ),
                              backgroundColor: AppConstants.errorColor,
                            ),
                          );
                        } else {
                          // Save result functionality
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Result saved successfully'),
                              backgroundColor: AppConstants.successColor,
                            ),
                          );
                        }
                      },
                      icon: Icon(isHighRisk ? Icons.emergency : Icons.save),
                      label: Text(
                        isHighRisk ? 'Get Help' : 'Save Result',
                        style: AppConstants.getResponsiveBodyStyle(context)
                            .copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: riskColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: AppConstants.getResponsivePadding(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
