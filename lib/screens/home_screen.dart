import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/symptom_analysis_provider.dart';
import '../utils/constants.dart';
import '../widgets/symptom_form.dart';
import '../widgets/environmental_sliders.dart';
import '../widgets/result_display.dart';
import 'data_browser_screen.dart';
import 'about_screen.dart';
import 'contact_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SymptomAnalysisProvider(),
      child: Consumer<SymptomAnalysisProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              title: Text(
                AppConstants.appName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: AppConstants.primaryColor,
              elevation: 0,
              centerTitle: true,
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: AppConstants.primaryColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.medical_services,
                          color: Colors.white,
                          size: 40,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          AppConstants.appName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.bar_chart),
                    title: const Text('Data Browser'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DataBrowserScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('About'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.contact_mail),
                    title: const Text('Contact'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ContactScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header Section
                  _buildHeaderSection(),

                  const SizedBox(height: AppConstants.largePadding),

                  // Symptom Form
                  SymptomForm(
                    initialFever: provider.fever,
                    initialBleeding: provider.bleeding,
                    initialHeadache: provider.headache,
                    initialVomiting: provider.vomiting,
                    onFeverChanged: provider.setFever,
                    onBleedingChanged: provider.setBleeding,
                    onHeadacheChanged: provider.setHeadache,
                    onVomitingChanged: provider.setVomiting,
                  ),

                  const SizedBox(height: AppConstants.largePadding),

                  // Environmental Sliders
                  EnvironmentalSliders(
                    initialHumidity: provider.humidity,
                    initialTemperature: provider.temperature,
                    onHumidityChanged: provider.setHumidity,
                    onTemperatureChanged: provider.setTemperature,
                  ),

                  const SizedBox(height: AppConstants.largePadding),

                  // Submit Button
                  _buildSubmitButton(context, provider),

                  const SizedBox(height: AppConstants.largePadding),

                  // Result Display
                  ResultDisplay(
                    result: provider.result,
                    isLoading: provider.isLoading,
                    errorMessage: provider.errorMessage,
                  ),

                  const SizedBox(height: AppConstants.largePadding),

                  // API Info (for debugging)
                  // _buildApiInfo(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppConstants.primaryColor, AppConstants.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
      ),
      child: Column(
        children: [
          Icon(Icons.medical_services, color: Colors.white, size: 48),
          const SizedBox(height: AppConstants.defaultPadding),
          Text(
            'Lassa Fever Detection',
            style: AppConstants.titleStyle.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.smallPadding),
          Text(
            'Report symptoms and environmental data for early detection',
            style: AppConstants.bodyStyle.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(
    BuildContext context,
    SymptomAnalysisProvider provider,
  ) {
    return SizedBox(
      height: AppConstants.buttonHeight,
      child: ElevatedButton(
        onPressed: provider.isLoading
            ? null
            : () => provider.submitData(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
          ),
          elevation: 2,
        ),
        child: provider.isLoading
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(width: AppConstants.smallPadding),
                  Text('Submitting...'),
                ],
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(Icons.send),
                  // SizedBox(width: AppConstants.smallPadding),
                  Text(
                    'Submit for Analysis',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
      ),
    );
  }
}
