import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppConstants.appName, style: AppConstants.titleStyle),
            const SizedBox(height: 8),
            Text(
              'Version: ${AppConstants.appVersion}',
              style: AppConstants.subtitleStyle,
            ),
            const SizedBox(height: 16),
            const Text(
              'AI4Lassa is a symptom reporter and fever detection app. It helps users report symptoms, browse statistical data, and learn more about Lassa fever.',
            ),
            const SizedBox(height: 24),
            const Text('Developed by Your Team Name.'),
          ],
        ),
      ),
    );
  }
}
